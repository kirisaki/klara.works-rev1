FROM ubuntu:18.04

#RUN mkdir /js

#COPY ./client/dist/ /js/

COPY ./server/dist/server /sbin/

CMD ["/sbin/server"]

