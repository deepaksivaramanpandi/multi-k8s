docker build -t deepaksivaramanpandi/multi-client:latest -t deepaksivaramanpandi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deepaksivaramanpandi/multi-server:latest -t deepaksivaramanpandi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deepaksivaramanpandi/multi-worker:latest -t deepaksivaramanpandi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deepaksivaramanpandi/multi-client:latest
docker push deepaksivaramanpandi/multi-server:latest
docker push deepaksivaramanpandi/multi-worker:latest

docker push deepaksivaramanpandi/multi-client:$SHA
docker push deepaksivaramanpandi/multi-server:$SHA
docker push deepaksivaramanpandi/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=deepaksivaramanpandi/multi-server:$SHA
kubectl set image deployments/client-deployment client=deepaksivaramanpandi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=deepaksivaramanpandi/multi-worker:$SHA