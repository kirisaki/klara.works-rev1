FROM ubuntu:18.04

RUN mkdir /assets/works -p

COPY ./client/dist/ /assets

COPY ./works/ /assets/works

COPY ./server/dist/server /sbin/

CMD ["/sbin/server"]

