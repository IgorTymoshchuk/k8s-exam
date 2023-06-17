kubectl apply -f 13-create-deployment-nginx.yaml
kubectl get deploy nginx-deploy -o yaml > 13-before-image-change.yaml
kubectl set image deployment/nginx-deploy nginx-deploy=nginx:1.17 --record=true
# kubectl rollout history deploy
kubectl get deploy nginx-deploy -o yaml > 13-after-image-change.yaml