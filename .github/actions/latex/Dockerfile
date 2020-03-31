FROM ukitomato/latex:full-1.0.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    python3 \
    && rm -rf /var/lib/apt/lists/*

RUN mktexlsr && mkdir -p /working
WORKDIR /working

ADD entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]