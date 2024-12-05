set -e

# ATTENTION: Fill this in
PATH_TO_YOUR_YAML_FILE="/home/andrew/Documents/projects/ai2-beaker-template/beaker/yaml/beaker-config-distrib.yaml"

sudo ./scripts/build.sh image-name

IMAGE_ID=$(openssl rand -hex 3)
beaker image create --name image-name-$IMAGE_ID image-name

sed -i.backup "s/image-name-\([a-zA-Z0-9]*\)/image-name-${IMAGE_ID}/g" $PATH_TO_YOUR_YAML_FILE

beaker experiment create $PATH_TO_YOUR_YAML_FILE