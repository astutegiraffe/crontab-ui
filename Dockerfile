# docker run -d -p 8000:8000 astutegiraffe/crontab-ui
FROM registry.hub.docker.com/library/node:14.6.0-alpine

LABEL maintainer "@astutegiraffe"
LABEL description "Crontab-UI docker"

ENV CRON_PATH=/etc/crontabs \
	HOST=0.0.0.0 \
	PORT=8000 \
	CRON_IN_DOCKER=true

COPY . /crontab-ui

WORKDIR /crontab-ui

RUN touch $CRON_PATH/root && \
	chmod +x $CRON_PATH/root && \
	npm install && \
	apk --no-cache add curl supervisor jq

EXPOSE $PORT

ENTRYPOINT ["supervisord"]
CMD ["-c", "/crontab-ui/supervisord.conf"]
