echo "Checking if any container is using port 8003..."
CID=$(docker ps -a --filter "publish=8003" --format="{{.ID}}")

if [ -z "$CID" ]; then
    echo "No container found on port 8003."
else
    echo "Stopping container $CID..."
    docker stop $CID
    echo "Removing container $CID..."
    docker rm $CID
fi
echo "Deploying the project..."
docker run -d -p 8003:80 adeshinadede/adeshina_bot