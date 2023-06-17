# 1 create webapp deployment
kubectl apply -f 01-webapp.yaml

# 2 Get the deployment rollout status
kubectl rollout status deployment/webapp
# Output:
# deployment "webapp" successfully rolled out

# 3. Get the replicaset that created with this deployment
kubectl get rs
# Output:
# NAME                DESIRED   CURRENT   READY   AGE
# webapp-6684ccd7b8   5         5         5       34s

# 4. EXPORT the yaml of the replicaset and pods of this deployment
kubectl get rs webapp-6684ccd7b8 -o yaml > webapp-6684ccd7b8.yaml
kubectl get pod webapp-6684ccd7b8-wxwvl -o yaml > webapp-6684ccd7b8-wxwvl.yaml

# 5. Delete the deployment you just created and watch all the pods are
# also being deleted
kubectl delete deploy webapp
kubectl get pods

# 6. Create a deployment of webapp with image nginx:1.17.1 with
# container port 80 and verify the image version
kubectl apply -f 06-webapp.yaml

# 7. Update the deployment with the image version 1.17.4 and verify
kubectl set image deployment/webapp nginx=nginx:1.17.4

# 8. Check the rollout history and make sure everything is ok after the
# update
kubectl rollout status deployment/webapp
# Output:
# deployment "webapp" successfully rolled out

# 9. Undo the deployment to the previous version 1.17.1 and verify Image
# has the previous version
kubectl rollout undo deployment/webapp --to-revision=1

# 10. Update the deployment with the wrong image version 1.100 and
# verify something is wrong with the deployment
kubectl set image deployment/webapp nginx=nginx:1.100
# Output:
# deployment.apps/webapp image updated
kubectl rollout status deployment/webapp
# Output:
# Waiting for deployment "webapp" rollout to finish: 1 old replicas are pending termination...

# 11. Apply the autoscaling to this deployment with minimum 10 and
# maximum 20 replicas and target CPU of 85% and verify hpa is
# created and replicas are increased to 10 from 1
kubectl autoscale deployment webapp --min=10 --max=20 --cpu-percent=85
# Output:
# horizontalpodautoscaler.autoscaling/webapp autoscaled
kubectl get pods | grep webapp

# Output:
# webapp-657545df75-nk7dj   1/1     Running     0          79s
# webapp-657545df75-9c8mr   1/1     Running     0          41s
# webapp-657545df75-bf8hl   1/1     Running     0          41s
# webapp-657545df75-7dc6f   1/1     Running     0          41s
# webapp-657545df75-h7x8t   1/1     Running     0          41s
# webapp-657545df75-qsjzv   1/1     Running     0          41s
# webapp-657545df75-t67zr   1/1     Running     0          41s
# webapp-657545df75-h6rj2   1/1     Running     0          41s
# webapp-657545df75-zxljt   1/1     Running     0          41s
# webapp-657545df75-ssn5n   1/1     Running     0          41s

# 13.Clean the cluster by deleting deployment and hpa you just created
k delete deploy webapp
k delete hpa webapp
# Output:
# deployment.apps "webapp" deleted
# horizontalpodautoscaler.autoscaling "webapp" deleted

# 14.Create a job and make it run 10 times one after one