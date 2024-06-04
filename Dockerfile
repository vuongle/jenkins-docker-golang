FROM golang:latest

WORKDIR /app

COPY . /app

CMD ["./main"]