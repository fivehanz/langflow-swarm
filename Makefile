MAKEFLAGS += -j2

prod-init: prod-nginx-link

# docker swarm
STACK_NAME = langflow
COMPOSE_FILE = ./docker-swarm.yml

prod-start:
	docker stack deploy -c $(COMPOSE_FILE) $(STACK_NAME) --detach=true

prod-update: prod-start

prod-stop:
	docker stack stop $(STACK_NAME)  # Stops services without removing configuration.

prod-rm:
	docker stack rm $(STACK_NAME)  # Removes the stack and all associated resources.

prod-nginx-link:
	ln -s ${shell pwd}/nginx.conf /etc/nginx/sites-enabled/lf.jsmx.org.conf
	nginx -s reload
