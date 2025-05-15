#!/bin/sh

set -e

# proxy pour PostgREST
curl -s -X POST http://toxiproxy:8474/proxies -H "Content-Type: application/json" -d '{
  "name": "postgrest",
  "listen": "0.0.0.0:4000",
  "upstream": "host.docker.internal:3000"
}'

# latence 1s ± 0.5
curl -s -X POST http://toxiproxy:8474/proxies/postgrest/toxics -H "Content-Type: application/json" -d '{
  "name": "latency_down_api",
  "type": "latency",
  "stream": "downstream",
  "attributes": {
    "latency": 1000,
    "jitter": 500
  }
}'

# proxy pour imgproxy
curl -s -X POST http://toxiproxy:8474/proxies -H "Content-Type: application/json" -d '{
  "name": "imgproxy",
  "listen": "0.0.0.0:4003",
  "upstream": "host.docker.internal:3003"
}'

# réduction de la bande passante à 25kbs⁻¹
curl -s -X POST http://toxiproxy:8474/proxies/imgproxy/toxics -H "Content-Type: application/json" -d '{
  "name": "bandwidth_throttle",
  "type": "bandwidth",
  "stream": "downstream",
  "attributes": {
    "rate": 25
  }
}'

echo "\n✅ Toxiproxy initialisé avec succès"
