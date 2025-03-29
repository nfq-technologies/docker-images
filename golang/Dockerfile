FROM nfqlt/toolbox-buster

ENV GOPATH /home/project/go
#ENV PATH $PATH:/usr/local/go/bin

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
