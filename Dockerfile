FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y gcc musl-dev git mercurial bash openssl make python3 wget
RUN wget -P /tmp https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go1.11.5.linux-amd64.tar.gz
RUN rm /tmp/go1.11.5.linux-amd64.tar.gz
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR /app
COPY setup_ngrok_server.sh /app/setup_ngrok_server.sh
RUN sh setup_ngrok_server.sh
WORKDIR /app/run
COPY server_for_download.py /app/run/server_for_download.py
COPY run.sh /app/run/run.sh
CMD ["sh", "run.sh"]
