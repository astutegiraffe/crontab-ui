# docker run -d -p 8000:8000 astutegiraffe/crontab-ui
FROM registry.hub.docker.com/library/node:14.6.0-alpine

LABEL maintainer "@astutegiraffe"
LABEL description "Crontab-UI docker"

ENV   CRON_PATH /etc/crontabs

RUN touch $CRON_PATH/root && \
	chmod +x $CRON_PATH/root && \
	apk --no-cache add curl supervisor

COPY . /crontab-ui
COPY supervisord.conf /etc/supervisord.conf

WORKDIR /crontab-ui

RUN   npm install

ENV   HOST 0.0.0.0

ENV   PORT 8000

ENV   CRON_IN_DOCKER true

EXPOSE $PORT

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
