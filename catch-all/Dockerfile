FROM mhart/alpine-node:6

ADD package.json ./src/package.json
RUN cd ./src && npm install

ADD . ./src
WORKDIR ./src

CMD ["npm", "start"]
