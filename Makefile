COMPOSE_FILE = ./srcs/docker-compose.yml

all: run

# fore-ground
run:
	@echo "Run in fore-ground"
	@sudo mkdir -p /home/donghank/data/wordpress
	@sudo mkdir -p /home/donghank/data/mysql
	@docker-compose -f $(COMPOSE_FILE) up

# back-ground
up:
	@echo "Run in back-ground"
	@sudo mkdir -p /home/donghank/data/wordpress
	@sudo mkdir -p /home/donghank/data/mysql
	@docker-compose -f $(COMPOSE_FILE) up -d

debug:
	@echo "Enter to debug mode"
	@sudo mkdir -p /home/donghank/data/wordpress
	@sudo mkdir -p /home/donghank/data/mysql
	@docker-compose -f $(COMPOSE_FILE) --verbose up

list:
	@echo "List up docker"
	@docker ps -a

volumes:
	@echo "Volumes docker"
	@docker volume list

clean:
	@echo "Unmount all services..."
	@docker-compose -f $(COMPOSE_FILE) down
	@echo "Delete docker container..."
	@docker stop $(docker ps -qa)
	@docker rm $(docker ps -qa)
	@echo "Delete images..."
	@docker rmi -f $(docker images -qa)
	@echo "Delete volumes..."
	@docker volume rm $(docker volume ls -q)
	@echo "Delete networks..."
	@docker network rm $(docker network ls -q)
	@echo "Delete all data wordpress and mysql..."
	@sudo rm -rf /home/donghank/data/wordpress
	@sudo rm -rf /home/donghank/data/mysql
	@echo "Delete completed!"

.PHONY: all run up debug list volumes clean
