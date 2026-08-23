FROM node:20-alpine

WORKDIR /app

COPY services/svc1/server.js ./server.js

ENV PORT=8000
EXPOSE 8000

USER node

CMD ["node", "server.js"]