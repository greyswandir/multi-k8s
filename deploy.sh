docker build -t olegvitko/complex-client:latest -t olegvitko/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t olegvitko/complex-server:latest -t olegvitko/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t olegvitko/complex-worker:latest -t olegvitko/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olegvitko/complex-client:latest
docker push olegvitko/complex-server:latest
docker push olegvitko/complex-worker:latest

docker push olegvitko/complex-client:$SHA
docker push olegvitko/complex-server:$SHA
docker push olegvitko/complex-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/client-deployment client=olegvitko/complex-client:$SHA
kubectl set image deployment/server-deployment server=olegvitko/complex-server:$SHA
kubectl set image deployment/worker-deployment worker=olegvitko/complex-worker:$SHA