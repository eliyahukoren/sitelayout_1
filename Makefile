build:
	docker-compose up -d

up:
	docker-compose up --build

stop:
	docker stop $(docker ps -a -q) && docker system prune -af --volumes

web:
	docker exec -it docker-symfony-mysql_web_1 bash

mysql:
	docker exec -it docker-symfony-mysql_db_1 bash
