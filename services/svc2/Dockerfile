FROM node:20-alpine

WORKDIR /app

COPY services/svc2/server.js ./server.js

ENV PORT=3000
EXPOSE 3000

USER node

CMD ["node", "server.js"]