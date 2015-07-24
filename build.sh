cat Dockerfile.template | sed -e "s/COMMIT_ID/"$1"/" > Dockerfile
docker build -t arcturus/gemini .
