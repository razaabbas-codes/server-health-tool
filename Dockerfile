FROM ubuntu:24.04 AS checks
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends shellcheck && rm -rf /var/lib/apt/lists/*
COPY server-health.sh .
RUN shellcheck server-health.sh

FROM ubuntu:24.04 AS runtime
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl procps && rm -rf /var/lib/apt/lists/*
COPY --from=checks /app/server-health.sh .
RUN chmod +x server-health.sh
CMD ["./server-health.sh"]
