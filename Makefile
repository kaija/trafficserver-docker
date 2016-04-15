
.PHONY: image run

all: image

image:
	docker build -t kaija/trafficserver6 .
run:
	docker run -d -p 8080:8080  kaija/trafficserver6
