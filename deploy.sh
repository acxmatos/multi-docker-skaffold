docker build -t acxmatos/multi-docker-client:latest -t acxmatos/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t acxmatos/multi-docker-server:latest -t acxmatos/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t acxmatos/multi-docker-worker:latest -t acxmatos/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push acxmatos/multi-docker-client:latest
docker push acxmatos/multi-docker-server:latest
docker push acxmatos/multi-docker-worker:latest

docker push acxmatos/multi-docker-client:$SHA
docker push acxmatos/multi-docker-server:$SHA
docker push acxmatos/multi-docker-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=acxmatos/multi-docker-client:$SHA
kubectl set image deployments/server-deployment server=acxmatos/multi-docker-server:$SHA
kubectl set image deployments/worker-deployment worker=acxmatos/multi-docker-worker:$SHA