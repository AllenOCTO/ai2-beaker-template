set -e

# ATTENTION: Fill this in
PATH_TO_YOUR_YAML_FILE="/home/andrew/Documents/projects/ai2-beaker-template/beaker/yaml/beaker-config-distrib.yaml"
IMAGE_NAME="dna-seq-models"
IMAGE_ID=$(openssl rand -hex 3)

sudo ./scripts/build.sh image-name

beaker image create --name $IMAGE_NAME-$IMAGE_ID $IMAGE_NAME

sed -i.backup "s/$IMAGE_NAME-\([a-zA-Z0-9]*\)/$IMAGE_NAME-${IMAGE_ID}/g" $PATH_TO_YOUR_YAML_FILE

beaker experiment create $PATH_TO_YOUR_YAML_FILE