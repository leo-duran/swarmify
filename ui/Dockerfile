FROM mhart/alpine-node:6

RUN npm install -g nodemon

ADD package.json ./src/package.json
RUN cd ./src && npm install

EXPOSE 3000

ADD . ./src
WORKDIR ./src

CMD ["npm", "start"]
