FROM node:8-alpine

ENV CODE /usr/src/app

ENV STAN_URL nats://nats-streaming.hack-tribe.svc.cluster.local:4223
ENV STAN_MONITOR_URL http://nats-streaming.hack-tribe.svc.cluster.local:8223
ENV STAN_CLUSTER warpin-pubsub

WORKDIR $CODE

RUN mkdir -p $CODE
COPY package.json $CODE
COPY yarn.lock $CODE
RUN yarn

ADD public $CODE/public
ADD server $CODE/server
ADD src $CODE/src

RUN yarn build-css
RUN yarn build

EXPOSE 8282
CMD ["node", "server"]
