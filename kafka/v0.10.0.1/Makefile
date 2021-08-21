.PHONY: build build-nocache push run test-producer test-consumer

#
# Compile the docker image
#
build:
	docker build -t davidoram/kafka:0.10.0.1 . --progress plain

#
# Compile the docker image no caching
#
build-nocache:
	docker build -t davidoram/kafka:0.10.0.1 . --progress plain --no-cache

# Push the application image to dockerhub
#
push:
	docker image push davidoram/kafka:0.10.0.1

#
# Run the image
#
run:
	docker run davidoram/kafka:0.10.0.1 

