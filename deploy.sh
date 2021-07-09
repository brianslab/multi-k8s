for image in client server worker; do 
    docker build -t brianslab/multi-$image:latest -t brianslab/multi-$image:$SHA -f ./$image/Dockerfile ./$image
    docker push brianslab/multi-$image:latest
    docker push brianslab/multi-$image:$SHA
done

kubectl apply -f k8s

for image in client server worker do
    kubectl set image deployments/$image-deployment server=brianslab/multi-$image:$SHA
done