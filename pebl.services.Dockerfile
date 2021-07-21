FROM node:14.7.0

COPY pebl-services/package.json /srv/
COPY pebl-services/package-lock.json /srv/
COPY pebl-services/localhost.crt /ssl/fullchain.pem
COPY pebl-services/localhost.key /ssl/privkey.pem
COPY pebl-services/ca.pem /ssl/ca.pem

WORKDIR /srv/

#RUN npm install --production
RUN npm install --production && npm run compile

COPY dockerConfig/startServices.sh /srv/startServices.sh
RUN chmod 755 /srv/startServices.sh

#COPY pebl-services/dist /srv/dist/
COPY pebl-services/src/serverConfig.json /srv/dist/serverConfig.json

ENTRYPOINT ["/srv/startServices.sh"]
