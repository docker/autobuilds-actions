FROM alpine:latest

RUN apk add --no-cache git openssh

COPY . .

RUN ls -al .
RUN chmod +x ./run_tests.sh
