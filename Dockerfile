FROM alpine:latest
COPY dotenv-filler.sh /usr/bin/dotenv-filler
ENTRYPOINT ["/bin/sh", "/usr/bin/dotenv-filler"]
