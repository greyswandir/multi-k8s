docker build -t olegvitko/multi-client:latest -t olegvitko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olegvitko/multi-server:latest -t olegvitko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olegvitko/multi-worker:latest -t olegvitko/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olegvitko/multi-client:latest
docker push olegvitko/multi-server:latest
docker push olegvitko/multi-worker:latest

docker push olegvitko/multi-client:$SHA
docker push olegvitko/multi-server:$SHA
docker push olegvitko/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/client-deployment client=olegvitko/multi-client:$SHA
kubectl set image deployment/server-deployment server=olegvitko/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=olegvitko/multi-worker:$SHA