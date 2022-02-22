FROM golang:1.17-alpine AS builder

LABEL maintainer="Martin Ramirez <@tinchoram> (https://tinchoram.com/)"

# should be replaced with your project name
WORKDIR /ram-web

# Copy all the Code and stuff to compile everything
COPY /cmd .
# Copy and download dependency using go mod.
COPY go.mod go.sum ./

# Downloads all the dependencies in advance (could be left out, but it's more clear this way)
RUN go mod download

# Builds the application as a staticly linked one, to allow it to run on alpine
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o app .


# Moving the binary to the 'final Image' to make it smaller
FROM alpine:latest

WORKDIR /app

# Create the `public` dir and copy all the assets into it
RUN mkdir ./public
COPY ./public ./public

# should be replaced here as well
COPY --from=builder /ram-web/app .

# Exposes port 3000 because our program listens on that port
EXPOSE 3000

CMD ["./app"]