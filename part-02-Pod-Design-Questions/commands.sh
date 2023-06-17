# 01 Get pods with label information
kubectl get pod --show-labels=true

# 02 Create 5 nginx pods in which two of them is labeled env=prod and
# three of them is labeled env=dev
for i in {1..2}; do kubectl run nginx$i --image=nginx --port=80 --labels="env=prod"; done
for i in {3..5}; do kubectl run nginx$i --image=nginx --port=80 --labels="env=dev"; done

# 03 Verify all the pods are created with correct labels
kubectl get pod --show-labels=true

# 04 Get the pods with label env=dev
kubectl get po -l="env=dev"

# 05 Get the pods with label env=dev and also output the labels
kubectl get pod -l="env=dev" --show-labels=true

# 06 Get the pods with label env=prod
kubectl get po -l="env=prod"

# 07 Get the pods with label env=prod and also output the labels
kubectl get pod -l="env=prod" --show-labels=true

# 08 Get the pods with label env
kubectl get po -l="env"
# 09 Get the pods with labels env=dev and env=prod
kubectl get pod -l="env in (dev,prod)"

# 10 Get the pods with labels env=dev and env=prod and output the labels as well
kubectl get pod -l="env in (dev,prod)" --show-labels=true

# 11 Change the label for one of the pod to env=uat and list all the pods to verify
kubectl label pod dev-36qlnhq7zj-47p1h env=uat --overwrite

# 12 Remove the labels for the pods that we created now and verify all the labels are removed
kubectl label pod dev-36qlnhq7zj-47p1h env-
kubectl label pod dev-36qlnhq7zj-pujya env-
kubectl label pod dev-36qlnhq7zj-5n1rh env-
kubectl label pod prod-6zjdhdwnzd-2h3ab env-
kubectl label pod prod-6zjdhdwnzd-b4e3h env-

# 13 Let’s add the label app=nginx for all the pods and verify (using kubectl)
kubectl label pod dev-36qlnhq7zj-47p1h app=nginx --overwrite
kubectl label pod dev-36qlnhq7zj-pujya app=nginx --overwrite
kubectl label pod dev-36qlnhq7zj-5n1rh app=nginx --overwrite
kubectl label pod prod-6zjdhdwnzd-2h3ab app=nginx --overwrite
kubectl label pod prod-6zjdhdwnzd-b4e3h app=nginx --overwrite

# 14 Get all the nodes with labels (if using minikube you would get only master node)
kubectl get nodes --show-labels=true

# 15 Label the worker node nodeName=nginxnode
kubectl label node k3d-k3s-default-server-0 k3d-k3s-default-server-0=nginxnode

# 16 Create a Pod that will be deployed on the worker node with the label nodeName=nginxnode
kubectl apply -f 16-pod.yaml

# 17 Verify the pod that it is scheduled with the node selector on the right
# node… fix it if it’s not behind scheduled.
kubectl get po  -o=yaml

# 18 Verify the pod nginx that we just created has this label
kubectl get pods --show-labels