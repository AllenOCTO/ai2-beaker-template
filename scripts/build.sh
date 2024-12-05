set -e

rm -rf ./artifacts/*

# copy whatever is needed into the artifacts folder
cp -r ./model ./artifacts
cp ./scripts/container-entrypoint.sh ./artifacts

docker build --tag $1 --file docker/amd64/Dockerfile ./artifacts