docker build -t olegvitko/multi-client -f ./client/Dockerfile ./client
docker build -t olegvitko/multi-server -f ./server/Dockerfile ./server
docker build -t olegvitko/multi-worker -f ./worker/Dockerfile ./worker

docker push olegvitko/multi-client
docker push olegvitko/multi-server
docker push olegvitko/multi-worker

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=olegvitko/multi-server