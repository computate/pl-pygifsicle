
# Examples: 

## --rotate-90

```bash
podman run --rm -v $PWD/incoming:/incoming -v $PWD/outgoing:/outgoing --privileged -it localhost/pl-pygifsicle:latest gifsicle --rotate-90 --resize-width 100 /incoming/python.gif -o /outgoing/python.gif
```

Before

![--rotate-90 before](incoming/python.gif)

After

![--rotate-90 after](outgoing/python.gif)

## --resize-width 200

```bash
podman run --rm -v $PWD/incoming:/incoming  -v $PWD/outgoing:/outgoing --privileged -it localhost/pl-pygifslce:latest gifsicle --resize-width 200  /incoming/giphy.gif -o /outgoing/giphy.gif
```

Before

![--rotate-90 before](incoming/giphy.gif)

After

![--rotate-90 after](outgoing/giphy.gif)

## --use-colormap 'gray'

```bash
podman run --rm -v $PWD/incoming:/incoming  -v $PWD/outgoing:/outgoing --privileged -it localhost/pl-pygifslce:latest gifsicle --resize-width 200  /incoming/giphy.gif -o /outgoing/giphy.gif
```

Before

![--use-colormap 'gray' before](incoming/jhin.gif)

After

![--use-colormap 'gray' after](outgoing/jhin.gif)


# ChRIS PLugin for pygifsicle

[![Version](https://img.shields.io/docker/v/fnndsc/pl-pygifsicle?sort=semver)](https://hub.docker.com/r/fnndsc/pl-pygifsicle)
[![MIT License](https://img.shields.io/github/license/fnndsc/pl-pygifsicle)](https://github.com/FNNDSC/pl-pygifsicle/blob/main/LICENSE)
[![ci](https://github.com/FNNDSC/pl-pygifsicle/actions/workflows/ci.yml/badge.svg)](https://github.com/FNNDSC/pl-pygifsicle/actions/workflows/ci.yml)

`pl-pygifsicle` is a [_ChRIS_](https://chrisproject.org/)
_ds_ plugin which takes in ...  as input files and
creates ... as output files.

## Abstract

...

## Installation

`pl-pygifsicle` is a _[ChRIS](https://chrisproject.org/) plugin_, meaning it can
run from either within _ChRIS_ or the command-line.

[![Get it from chrisstore.co](https://raw.githubusercontent.com/FNNDSC/ChRIS_store_ui/963938c241636e4c3dc4753ee1327f56cb82d8b5/src/assets/public/badges/light.svg)](https://chrisstore.co/plugin/pl-pygifsicle)

## Local Usage

To get started with local command-line usage, use [Apptainer](https://apptainer.org/)
(a.k.a. Singularity) to run `pl-pygifsicle` as a container:

```shell
apptainer exec docker://fnndsc/pl-pygifsicle pygifsicle [--args values...] input/ output/
```

To print its available options, run:

```shell
apptainer exec docker://fnndsc/pl-pygifsicle pygifsicle --help
```

## Examples

`pygifsicle` requires two positional arguments: a directory containing
input data, and a directory where to create output data.
First, create the input directory and move input data into it.

```shell
mkdir incoming/ outgoing/
mv some.dat other.dat incoming/
apptainer exec docker://fnndsc/pl-pygifsicle:latest pygifsicle [--args] incoming/ outgoing/
```

## Development

Instructions for developers.

### Building

Build a local container image:

```shell
docker build -t localhost/fnndsc/pl-pygifsicle .
```

### Running

Mount the source code `pygifsicle.py` into a container to try out changes without rebuild.

```shell
docker run --rm -it --userns=host -u $(id -u):$(id -g) \
    -v $PWD/pygifsicle.py:/usr/local/lib/python3.10/site-packages/pygifsicle.py:ro \
    -v $PWD/in:/incoming:ro -v $PWD/out:/outgoing:rw -w /outgoing \
    localhost/fnndsc/pl-pygifsicle pygifsicle /incoming /outgoing
```

### Testing

Run unit tests using `pytest`.
It's recommended to rebuild the image to ensure that sources are up-to-date.
Use the option `--build-arg extras_require=dev` to install extra dependencies for testing.

```shell
docker build -t localhost/fnndsc/pl-pygifsicle:dev --build-arg extras_require=dev .
docker run --rm -it localhost/fnndsc/pl-pygifsicle:dev pytest
```

## Release

Steps for release can be automated by [Github Actions](.github/workflows/ci.yml).
This section is about how to do those steps manually.

### Increase Version Number

Increase the version number in `setup.py` and commit this file.

### Push Container Image

Build and push an image tagged by the version. For example, for version `1.2.3`:

```
docker build -t docker.io/fnndsc/pl-pygifsicle:1.2.3 .
docker push docker.io/fnndsc/pl-pygifsicle:1.2.3
```

### Get JSON Representation

Run [`chris_plugin_info`](https://github.com/FNNDSC/chris_plugin#usage)
to produce a JSON description of this plugin, which can be uploaded to a _ChRIS Store_.

```shell
docker run --rm localhost/fnndsc/pl-pygifsicle:dev chris_plugin_info > chris_plugin_info.json
```

