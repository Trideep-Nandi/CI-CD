# TODO: add here
FROM node:22-slim

RUN mkdir -p /home/node/app 
RUN chown node:node /home/node/app

WORKDIR /home/node/app

COPY package*.json ./

RUN npm update -g npm

RUN npm install
RUN npx browserslist@latest --update-db

USER node

COPY --chown=node:node . .

EXPOSE 3000

ENTRYPOINT [ "npm" ]

CMD ["start"]