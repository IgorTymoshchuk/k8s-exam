kubectl create svc clusterip messaging-service --tcp=6379:6379
kubectl label svc messaging-service tier=msg