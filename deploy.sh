if [ -z "$1" ]; then
  echo "deploy.sh 3 - deploy 3 instances"
  exit -1
fi

echo "Finding all currently running containers"
OLD_IDS=(`docker ps | grep arcturus/gemini | awk '{print $1}' | cut -c1-8`)

echo "Starting new containers"
for i in `seq 1 $1`; do
  JOB=`docker run -d -p 1460 -e VIRTUAL_HOST=gemini.centralnex.us -t arcturus/gemini | cut -c1-8`
  echo "  Deployed Gemini $JOB"
done

echo "Removing old containers"
for i in ${OLD_IDS[@]}; do
  echo "  Killing $i"
  docker kill $i > /dev/null
done
