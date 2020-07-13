FROM ruby:2.7.1-alpine

RUN apk add --update --no-cache \
    build-base \
    tzdata \
    bash \
    nodejs \
    git

RUN mkdir app

WORKDIR /app