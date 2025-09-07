COMPOSE_FILE := $(PWD)/srcs/docker-compose.yml
DATA_DIR := $(HOME)/data

all:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress
	@$(MAKE) build
	@$(MAKE) create
	@$(MAKE) up

build:
	@
	@docker compose -f $(COMPOSE_FILE) build 

create:
	@docker compose -f $(COMPOSE_FILE) create

up:
	@docker compose -f $(COMPOSE_FILE) up --build 

down:
	@docker compose -f $(COMPOSE_FILE) down

downv:
	@docker compose -f $(COMPOSE_FILE) down -v

stop:
	@docker compose -f $(COMPOSE_FILE) stop

start:
	@docker compose -f $(COMPOSE_FILE) start

logs:
	@docker compose -f $(COMPOSE_FILE) logs -f

clean: down
	@docker system prune -af --volumes

fclean: clean downv
	@docker system prune -af --volumes

re: fclean all
