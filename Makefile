CONTAINER_NAME=elegoo_ros2

docker-build:
	sudo docker build -t elegoo_src_ros2_ws .

docker-run:
	@if sudo docker ps -a --format '{{.Names}}' | grep -wq $(CONTAINER_NAME); then \
		echo "Removing existing container $(CONTAINER_NAME)..."; \
		sudo docker rm -f $(CONTAINER_NAME); \
	fi; \
	echo "Creating and running new container $(CONTAINER_NAME)..."; \
	sudo docker run --network=host --name $(CONTAINER_NAME) -it elegoo_src_ros2_ws

docker-stop:
	sudo docker stop $(CONTAINER_NAME)

docker-clean:
	sudo docker rmi -f $$(sudo docker images -q)

docker-clean-dangling:
	sudo docker rmi -f $$(sudo docker images -f "dangling=true" -q)

docker-shell:
	@if sudo docker ps -a --format '{{.Names}}' | grep -wq $(CONTAINER_NAME); then \
		echo "Removing existing container $(CONTAINER_NAME)..."; \
		sudo docker rm -f $(CONTAINER_NAME); \
	fi; \
	echo "Creating and running new container $(CONTAINER_NAME)..."; \
	sudo docker run --network=host --name $(CONTAINER_NAME) -it elegoo_src_ros2_ws /bin/bash