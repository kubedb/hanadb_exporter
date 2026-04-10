FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt setup.py README.md LICENSE MANIFEST.in ./
COPY hanadb_exporter ./hanadb_exporter
COPY bin/hanadb_exporter ./bin/hanadb_exporter
RUN mkdir -p /etc/hanadb_exporter
COPY metrics.json /etc/hanadb_exporter/metrics.json

RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir .

ENTRYPOINT ["hanadb_exporter"]
