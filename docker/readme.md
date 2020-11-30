# Hello World Docker Image

This is a very simple nginx image with a hello world page that is customizable via a configured environment variable at runtime. It is meant to showcase the very basics of how we can set some properties on our managed service in kubernetes with the different tools listed in the outline.md.

## Requirements

- docker

## Instructions

- `docker build ../docker -t default`
- 'docker run --rm -it -p 8080:80 default'
- open browser at http://localhost:8080/
