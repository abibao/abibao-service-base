FROM mhart/alpine-node:6

MAINTAINER Gilles Perreymond <gperreymond@gmail.com>

RUN mkdir -p /usr/app
WORKDIR /usr/app

COPY package.json /usr/app/
ADD srv /usr/app

RUN apk add --update make gcc g++ python && \
    npm install --production && \
    npm uninstall -g npm && \
    apk del make gcc g++ python && \
    rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp

CMD ["node", "/usr/app/start.js", "--seneca.options.tag=nodezoo-base", "--seneca-log=type:act"]
