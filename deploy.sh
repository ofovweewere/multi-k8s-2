docker build -t emanewere/multi-client-2:latest -t emanewere/multi-client-2:$SHA  -f ./client/Dockerfile ./client 
docker build -t emanewere/multi-server-2:latest -t emanewere/multi-server-2:$SHA -f ./server/Dockerfile ./server
docker build -t emanewere/multi-worker-2:latest -t emanewere/multi-worker-2:$SHA -f ./worker/Dockerfile ./worker
docker push emanewere/multi-client-2:latest
docker push emanewere/multi-server-2:latest
docker push emanewere/multi-worker-2:latest
docker push emanewere/multi-client-2:$SHA
docker push emanewere/multi-server-2:$SHA
docker push emanewere/multi-worker-2:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=emanewere/multi-server-2:$SHA
kubectl set image deployments/client-deployment client=emanewere/multi-client-2:$SHA
kubectl set image deployments/worker-deployment worker=emanewere/multi-worker-2:$SHA