## PostgreSQL

PostgreSQL est un système de gestion de base de données relationnelle open source, connu pour sa fiabilité et sa conformité aux standards SQL. 
Il permet de stocker, organiser et interroger des données structurées, avec un support avancé des types, des transactions et des extensions. 
Utilisé aussi bien pour des applications simples que complexes, il est largement adopté dans les environnements professionnels.


## PostGREST

PostgREST est un serveur web qui transforme une base de données PostgreSQL en une **API RESTful** automatique, basée uniquement sur les métadonnées SQL. 
Il permet d’interagir avec la base en lecture et en écriture via des requêtes HTTP, en respectant les droits définis par les rôles PostgreSQL. 
Cela facilite la création rapide d’API sécurisées et maintenables sans écrire de code backend personnalisé.

## Postgraphile

PostGraphile crée automatiquement une **API GraphQL** à partir d’une base PostgreSQL en utilisant sa structure et ses règles d’accès. 
Il s'appuie sur les tables, les vues, les relations et les permissions définies dans la base pour exposer un schéma GraphQL complet sans écrire de code serveur. 

## php-crud-api

php-crud-api est une API REST générée automatiquement à partir d'une base de données MySQL, PostgreSQL, SQL Server ou SQLite. 
Écrite en PHP, elle expose les tables de la base sous forme de ressources accessibles via des requêtes HTTP. 
Elle permet de gérer les opérations CRUD (Create, Read, Update, Delete) sans écrire de code serveur supplémentaire.

`php-crud-api` utilise **TreeQL** comme format de requête pour exprimer des lectures complexes dans l'API REST. 
TreeQL permet de spécifier des filtres, des tris, des jointures et des projections dans une syntaxe concise passée via l’URL. 
Ainsi, `php-crud-api` s'appuie sur TreeQL pour offrir une grande expressivité dans les requêtes tout en restant conforme au style REST.

## imgproxy

imgproxy est un serveur open source conçu pour redimensionner, convertir et optimiser les images à la volée via des requêtes HTTP. 
Il bénéficie de performances élevées avec une faible consommation de mémoire, permettant de traiter efficacement un grand volume d'images. 
Grâce à sa prise en charge de divers formats (JPEG, PNG, WebP, AVIF, etc.) et à ses fonctionnalités de sécurité intégrées (comme la signature d'URL et la limitation des dimensions), imgproxy est adapté à une utilisation en production derrière un CDN ou un proxy inverse. 

## Toxiproxy 

Toxiproxy est un outil open source développé par Shopify qui agit comme un proxy TCP permettant de simuler diverses conditions réseau, 
telles que la latence, la perte de paquets ou les coupures de connexion, afin de tester la résilience des applications.

Il est conçu pour les environnements de développement, d'intégration continue et de test, offrant une API dynamique pour injecter des perturbations réseau (appelées toxics) de manière contrôlée ou aléatoire.

Grâce à Toxiproxy, les développeurs peuvent identifier les points de défaillance potentiels de leurs systèmes distribués et améliorer la tolérance aux pannes en simulant des scénarios de dégradation réseau réalistes.
