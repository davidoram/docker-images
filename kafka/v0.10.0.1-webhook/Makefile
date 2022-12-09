# This Makefile only used for local testing of the Docker build.
#
# The docker build is run by a Github Action - see  /.github/workflows/build-kafka-0.10.0.1.yaml
#
.PHONY: build build-nocache push run test-producer test-consumer

#
# Setup a dockerx builder called 'multiplatform-builder'
#
setup:
	docker buildx create --name multiplatform-builder
	docker buildx use multiplatform-builder
	docker buildx inspect --bootstrap


# Display the dockerx builder 'multiplatform-builder'
#
inspect:
	docker buildx use multiplatform-builder
	docker buildx inspect

#
# Compile the docker image, & push to dockerhub
#
build:
	docker buildx build --platform=linux/amd64,linux/arm64 --tag=davidoram/kafka-webhook:0.10.0.1 --push .

#
# Compile the docker image no caching, & push to dockerhub
#
build-nocache:
	docker buildx build --platform=linux/amd64,linux/arm64 --tag=davidoram/kafka-webhook:0.10.0.1 --no-cache --push .

# Display the manifest
#
manifest:
	docker manifest inspect --verbose davidoram/kafka-webhook:0.10.0.1
#
# Run the image
#
run:
	docker run davidoram/kafka-webhook:0.10.0.1

