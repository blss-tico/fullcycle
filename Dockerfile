# Author: blss-tico (github.com/blss-tico)
# first stage orginal image
FROM golang:1.21rc3-alpine AS stg1
WORKDIR /go
COPY main.go ./src
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o ./bin/main ./src/main.go
CMD ["/go/bin/main"]

# second stage small image
FROM scratch
COPY --from=stg1 /go/bin/main /
CMD ["/main"]
