FROM alpine:3.19
ENV PYTHONUNBUFFERED=1
# c, clang, java, nasm
USER root
RUN apk update && \
    apk add vim bash nasm gcc clang openjdk17-jdk &&\
	rm -rf /var/cache/apk/*
#python3
RUN apk add --update --no-cache python3 py3-pip && ln -sf python3 /usr/bin/python
WORKDIR /usr/src/pi2
COPY ./examples /usr/src/pi2/examples
# Set the command to keep the container running
CMD ["tail", "-f", "/dev/null"]

