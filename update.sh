#!/bin/bash

if [ -z ${PLUGIN_CLUSTER} ]; then
  echo "missing cluster"
  exit 1
fi

if [ -z ${PLUGIN_IMAGE_NAME} ]; then
  echo "missing image"
  exit 1
fi

if [ -z ${PLUGIN_SERVICE} ]; then
  echo "missing Service"
  exit 1
fi

if [ -z ${PLUGIN_AWS_REGION} ]; then
  PLUGIN_AWS_REGION="us-east-1"
fi

if [ -z ${PLUGIN_TIMEOUT} ]; then
  PLUGIN_TIMEOUT="600"
fi

if [ -z ${PLUGIN_MAX} ]; then
  PLUGIN_MAX="200"
fi

if [ -z ${PLUGIN_MIN} ]; then
  PLUGIN_MIN="100"
fi

if [ ! -z ${PLUGIN_AWS_ACCESS_KEY_ID} ]; then
  export AWS_ACCESS_KEY_ID=$PLUGIN_AWS_ACCESS_KEY_ID
fi

if [ ! -z ${PLUGIN_AWS_SECRET_ACCESS_KEY} ]; then
  export AWS_SECRET_ACCESS_KEY=$PLUGIN_AWS_SECRET_ACCESS_KEY
fi

export $AWS_ACCESS_KEY_ID
export $AWS_SECRET_ACCESS_KEY

ecs-deploy --region ${PLUGIN_AWS_REGION} --cluster ${PLUGIN_CLUSTER} --image ${PLUGIN_IMAGE_NAME} \
--service-name ${PLUGIN_SERVICE} --timeout ${PLUGIN_TIMEOUT} --min ${PLUGIN_MIN} --max ${PLUGIN_MAX} --force-new-deployment ${PLUGIN_FORCE_NEW_DEPLOYMENT}
