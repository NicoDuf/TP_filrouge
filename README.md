# Projet fil rouge

## Introduction

Ce projet est une application microservices construite avec Node.js et React. Il est conçu pour être déployé sur Kubernetes.

## Table des matières

- [Introduction](#introduction)
- [Table des matières](#table-des-matières)
- [Architecture](#architecture)
- [Chemins d'Ingress](#chemins-dingress)
- [Noms de Services Kubernetes](#noms-de-services-kubernetes)
- [Ports des Services](#ports-des-services)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Déploiement](#déploiement)

## Architecture

L'application est composée des services suivants :

- **Client** : Interface utilisateur construite avec React.
- **Posts** : Service pour la gestion des posts.
- **Comments** : Service pour la gestion des commentaires.
- **Query** : Service pour la gestion des requêtes.
- **Moderation** : Service pour la modération des commentaires.
- **Event Bus** : Service pour la gestion des événements entre les services.

### Chemins d'Ingress

- `/posts/create` : Dirigé vers le service `posts-clusterip-srv` sur le port 4000.
  - Utilisé pour créer de nouveaux posts.
  
- `/posts` : Dirigé vers le service `query-srv` sur le port 4002.
  - Utilisé pour récupérer la liste des posts existants.
  
- `/posts/?(.*)/comments` : Dirigé vers le service `comments-srv` sur le port 4001.
  - Utilisé pour créer ou récupérer les commentaires associés à un post spécifique.
  
- `/?(.*)` : Dirigé vers le service `client-srv` sur le port 3000.
  - Utilisé pour accéder à l'interface utilisateur.
 


### Noms de Services Kubernetes

Assurez-vous que les noms de services dans vos fichiers de déploiement Kubernetes correspondent aux noms de services utilisés dans le code de l'application. Voici les noms de services attendus :

- **client-srv**: Service pour l'interface utilisateur.
- **posts-clusterip-srv**: Service pour la gestion des posts.
- **query-srv**: Service pour la gestion des requêtes.
- **comments-srv**: Service pour la gestion des commentaires.
- **moderation-srv**: Service pour la modération des commentaires.
- **event-bus-srv**: Service pour la gestion des événements entre les services.

Si vous modifiez ces noms, assurez-vous également de mettre à jour les références correspondantes dans le code de l'application.


### Ports des Services

Chaque service écoute sur un port spécifique. Assurez-vous que ces ports sont correctement configurés dans vos fichiers de déploiement Kubernetes et dans tout autre outil de gestion des conteneurs que vous pourriez utiliser. Voici les ports attendus pour chaque service :

- **client-srv**: Écoute sur le port 3000.
- **posts-clusterip-srv**: Écoute sur le port 4000.
- **query-srv**: Écoute sur le port 4002.
- **comments-srv**: Écoute sur le port 4001.
- **moderation-srv**: Écoute sur le port 4003.
- **event-bus-srv**: Écoute sur le port 4005.

Si vous modifiez ces ports, assurez-vous également de mettre à jour les références correspondantes dans le code de l'application et les fichiers de configuration Kubernetes.


## Prérequis

- Node.js
- Docker
- Kubernetes

## Installation

1. Clonez ce dépôt :
    ```bash
    git clone https://github.com/Mossbaddi/Pojet_fil_rouge.git
    ```

2. Installez les dépendances pour chaque service :
    ```bash
    cd client && npm install
    cd ../posts && npm install
    # Répétez pour tous les services
    ```

## Déploiement

1. Construisez les images Docker pour chaque service :
    ```bash
    docker build -t client ./client
    docker build -t posts ./posts
    # Répétez pour tous les services
    ```
    Le projet est basé sur l'image **node:alpine**

2. Déployez les services sur Kubernetes :
    ```bash
    kubectl apply -f k8s/
    ```

# Installation de l'application

  Phases : 
    - preparation du dossier projet
    - construction des images Docker
    - deploiement des services sur kubernetes
      > deploiement
      > verification
    - test

   
1. Preparer le projet dans un dossier git:
   
   installer le logiciel git si vous ne l'avez pas sur votre ordinateur (ci join la procédure : *https://learn.microsoft.com/fr-fr/devops/develop/git/install-and-set-up-git*)
### Preparer le dossier 'Projet_1': ouvrir un  terminal 'power shell'et taper les commandes
  ```bash
  mkdir Projet_1
  cd Projet_1
  git clone https://github.com/NicoDuf/TP_filrouge.git
  ```
    votre systeme sera donc dans le dossier 'Projet_1'
  
  
1. Construisez les images Docker pour chaque service de l'application:
### sur le terminal construiser les images 'docker' par les commandes suivantes :

  ```bash
  docker build -t query ./query
  docker build -t client ./client
  docker build -t moderation ./moderation
  docker build -t comments ./comments
  docker build -t event-bus ./event-bus
  ```
si vous souhaitez verifier vous lancer la commande ci dessous sur le terminal :
  ```bash
  docker images
   ```
  cela doit vous donner le resultat :
|REPOSITORY  |   TAG   |
|------------|---------|
|query       |   latest|
|posts       |   latest|
|moderation  |   latest|
|event-bus   |   latest|
|comments    |   latest|
|client      |   latest|


### deployer le service client
lancer la commande ci dessous sur le terminal :
  ```bash
  kubectl apply -f client-srv.yml
  kubectl apply -f event-bus-srv.yml
  kubectl apply -f moderation-srv.yml
  kubectl apply -f query-srv.yml
  kubectl apply -f comments-srv.yml
  ```

### vérifier que les services sont bien depoyés par la commande dans le terminal : 
lancer la commande ci dessous sur le terminal :
```bash
kubectl get deployments
```
  
  la réponse doit montré :
|NAME       |   READY |  UP-TO-DATE |  AVAILABLE | AGE|
|-------------|----------|----------|-----------|--------|
|client     |   1/1  |   1     | 1 | (suivant le moment deployé)|
|comments   |   1/1  |   1     | 1 | (suivant le moment deployé)|
|event-bus  |   1/1  |   1     | 1 | (suivant le moment deployé)|
|moderation |   1/1  |   1     | 1 | (suivant le moment deployé)|
|posts      |   1/1  |   1     | 1 | (suivant le moment deployé)|
|query      |   1/1  |   1     | 1 | (suivant le moment deployé)|

### deployer l'objet ingress
lancer la commande ci dessous sur le terminal :
```bash
kubectl apply -f ingress-srv.yml
```

### vérifier que le deployement : 
lancer la commande ci dessous sur le terminal :
```bash
kubectl get ingress
```
 la réponse doit etre la suivante :

| NAME        | CLASS  | HOSTS                                       | ADDRESS   |  PORTS  |
|-------------|-------------|-------------|-------------|------------|
| ingress-srv | <none> | localhost,localhost,localhost + 2 more...   | localhost |  80     |

d'autres vérifications peuvent etre réalisé