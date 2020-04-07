FROM ubuntu:18.04

RUN mkdir /assets

COPY ./client/dist/ /assets

COPY ./server/dist/server /sbin/

CMD ["/sbin/server"]

