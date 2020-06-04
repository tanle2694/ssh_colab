FROM golang:1.11-alpine
WORKDIR /app
RUN apk --no-cache add gcc musl-dev git mercurial bash openssl make python3
COPY setup_ngrok_server.sh /app/setup_ngrok_server.sh

RUN sh setup_ngrok_server.sh
WORKDIR /app/run
COPY server_for_download.py /app/run/server_for_download.py
COPY run.sh /app/run/run.sh

CMD ["sh", "run.sh"]
