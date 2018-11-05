FROM golang:1.11
WORKDIR /go/src/github.com/kawamuray/prometheus-json-exporter/
COPY json_exporter.go /go/src/github.com/kawamuray/prometheus-json-exporter/
COPY jsonexporter /go/src/github.com/kawamuray/prometheus-json-exporter/jsonexporter
RUN go get  -d ./...
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .




FROM alpine:3.7
LABEL description="Prometheus JSON exporter"
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/kawamuray/prometheus-json-exporter/prometheus-json-exporter .
CMD /root/prometheus-json-exporter
