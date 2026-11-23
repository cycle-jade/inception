NAME = inception
DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml
DATA_PATH = $(HOME)/data

all: $(NAME)

$(NAME):
	@echo "Creating volume directories..."
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@sudo mkdir -p $(DATA_PATH)/wordpress
	@echo "Starting containers..."
	@$(DOCKER_COMPOSE) up -d --build

down:
	@echo "Stopping containers..."
	@$(DOCKER_COMPOSE) down

clean: down
	@echo "Cleaning containers and networks..."
	@docker system prune -af

fclean: clean
	@echo "Removing volumes and data..."
	@sudo rm -rf $(DATA_PATH)
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $$(docker volume ls -q); \
	fi

re: fclean all
