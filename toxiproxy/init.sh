#!/bin/sh

set -e

# proxy pour PostgREST
# "upstream": "host.docker.internal:4000"
curl -s -X POST http://toxiproxy:8474/proxies -H "Content-Type: application/json" -d '{
  "name": "postgrest",
  "listen": "0.0.0.0:9001",
  "upstream": "postgrest:8001"
}'

# proxy pour postgraphile
curl -s -X POST http://toxiproxy:8474/proxies -H "Content-Type: application/json" -d '{
  "name": "postgraphile",
  "listen": "0.0.0.0:9002",
  "upstream": "postgraphile:8002"
}'

# proxy pour php-crud-api
curl -s -X POST http://toxiproxy:8474/proxies -H "Content-Type: application/json" -d '{
  "name": "php-crud-api",
  "listen": "0.0.0.0:9003",
  "upstream": "phpcrudapi:8003"
}'

# proxy pour imgproxy
curl -s -X POST http://toxiproxy:8474/proxies -H "Content-Type: application/json" -d '{
  "name": "imgproxy",
  "listen": "0.0.0.0:9004",
  "upstream": "imgproxy:8004"
}'

# latence 750ms ± 250
curl -s -X POST http://toxiproxy:8474/proxies/postgrest/toxics -H "Content-Type: application/json" -d '{
  "name": "latency_down_api",
  "type": "latency",
  "stream": "downstream",
  "attributes": {
    "latency": 750,
    "jitter": 250
  }
}'

curl -s -X POST http://toxiproxy:8474/proxies/php-crud-api/toxics -H "Content-Type: application/json" -d '{
  "name": "latency_down_api",
  "type": "latency",
  "stream": "downstream",
  "attributes": {
    "latency": 750,
    "jitter": 250
  }
}'

# réduction de la bande passante à 25kbs⁻¹
curl -s -X POST http://toxiproxy:8474/proxies/imgproxy/toxics -H "Content-Type: application/json" -d '{
  "name": "bandwidth_throttle",
  "type": "bandwidth",
  "stream": "downstream",
  "attributes": {
    "rate": 20
  }
}'

echo "\n✅ Toxiproxy initialisé avec succès"
