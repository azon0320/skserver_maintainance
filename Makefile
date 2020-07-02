
.PHONY: docker
docker: 
	docker build -t pmcli-7.2.22 -f Dockerfile util/
