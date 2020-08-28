docker build -t ghislop4/multi-client:latest -t ghislop4/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ghislop4/multi-server:latest -t ghislop4/multi-server:$SHA  -f ./Server/Dockerfile ./Server
docker build -t ghislop4/multi-worker:latest -t ghislop4/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push ghislop4/multi-client:latest
docker push ghislop4/multi-client:$SHA
docker push ghislop4/multi-server:latest
docker push ghislop4/multi-server:$SHA
docker push ghislop4/multi-worker:latest
docker push ghislop4/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ghislop4/multi-server:$SHA
kubectl set image deployments/client-deployment client=ghislop4/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ghislop4/multi-worker:$SHA