#!/bin/bash

kubectl apply -R -f client-srv.yml
kubectl apply -R -f query-srv.yml
kubectl apply -R -f moderation-srv.yml
kubectl apply -R -f posts-clusterip-srv.yml
kubectl apply -R -f client-srv.ymlch
kubectl apply -f ingress-srv.yml