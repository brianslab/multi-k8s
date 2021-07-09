docker build -t brianslab/multi-client:latest -t brianslab/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brianslab/multi-server:latest -t brianslab/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brianslab/multi-worker:latest -t brianslab/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brianslab/multi-client:latest
docker push brianslab/multi-server:latest
docker push brianslab/multi-worker:latest

docker push brianslab/multi-client:$SHA
docker push brianslab/multi-server:$SHA
docker push brianslab/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brianslab/multi-server:$SHA
kubectl set image deployments/client-deployment client=brianslab/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brianslab/multi-worker:$SHA