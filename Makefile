SRC= srcs/

DOCK_COMP= docker-compose.yml

COMP= $(SRC)$(DOCK_COMP)

WP= ${HOME}/data/html
MDB= ${HOME}/data/mariadb

all:
	mkdir -p $(WP)
	mkdir -p $(MDB)
	docker-compose -f $(COMP) up -d --build

down:
	docker-compose -f $(COMP) down -v --remove-orphans
	docker volume prune --force
	sudo rm -rf ${WP}/*
	sudo rm -rf ${MDB}/*

start:
	docker-compose -f $(COMP) start

stop:
	docker-compose -f $(COMP) stop

restart: stop
	docker-compose -f $(COMP) up -d

rebuild:
	docker-compose -f $(COMP) down
	docker-compose -f $(COMP) up -d --build

ps:
	docker-compose -f $(COMP) ps -a

logs:
	docker-compose -f $(COMP) logs -f

clean: down
	docker system prune -a --volumes

fclean: down
	docker system prune -a --volumes -f
	sudo rm -rf ${WP}
	sudo rm -rf ${MDB}

re: fclean
	make all

.PHONY: all clean re start stop restart rebuild ps log