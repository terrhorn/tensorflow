BUILDNUM=local
BRANCH=local

.PHONY: build
build:
	docker build -t terryhorner/tensorflow:local .

.PHONY: bash
bash:
	docker exec -it tensorflow bash

.PHONY: run
run:
	docker run -itd --rm -p 8888:8888 --name tensorflow terryhorner/tensorflow:local

.PHONY: stop
stop:
	docker stop tensorflow

.PHONY: cleanup
cleanup:
	-docker rm $$(docker ps --no-trunc -aq)
	-docker volume rm $$(docker volume ls -qf dangling=true)
	-docker rmi $$(docker images --quiet --filter "dangling=true")

.PHONY: publish
publish:
	docker push terryhorner/tensorflow
