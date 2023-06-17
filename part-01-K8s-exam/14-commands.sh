kubectl delete -f 14-pod-with-service.yaml
kubectl delete pod busybox
rm ./14-nginx-igor.svc ./14-nginx-igor.pod

kubectl apply -f 14-pod-with-service.yaml
kubectl wait --for=condition=Ready service/nginx-resolver-service
sleep 2
kubectl run busybox --restart=Never --image=busybox:1.28 -- wget nginx-resolver-service.default.svc.cluster.local
kubectl wait --for=condition=Ready pod/busybox
kubectl logs busybox > ./14-nginx-igor.svc
kubectl delete pod busybox

ip=`kubectl get pod nginx-resolver --template '{{.status.podIP}}' | tr . -`
kubectl run busybox --restart=Never --image=busybox:1.28 -- wget $ip.default.pod.cluster.local
kubectl wait --for=condition=Ready pod/busybox
kubectl logs busybox > ./14-nginx-igor.pod
kubectl delete pod busybox
echo service result:
cat 14-nginx-igor.svc
echo pod result:
cat 14-nginx-igor.pod
