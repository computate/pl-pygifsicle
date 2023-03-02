# Python version can be changed, e.g.
# FROM python:3.8
# FROM docker.io/fnndsc/conda:python3.10.2-cuda11.6.0
FROM docker.io/python:3.11.0-slim-bullseye

LABEL org.opencontainers.image.authors="FNNDSC <computate@computate.org>" \
      org.opencontainers.image.title="ChRIS PLugin for pygifsicle" \
      org.opencontainers.image.description="A ChRIS plugin to modify animated GIF images"

WORKDIR /usr/local/src/pl-pygifsicle

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
ARG extras_require=none
RUN pip install ".[${extras_require}]"

CMD ["pygifsicle"]
