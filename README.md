# Dockerization of DPDK

This repository provides tools to build Docker images with DPDK environment useful
for both development and runtime deployment. There are several Dockerfiles for
different operating systems with more-less equivalent contents. Each Docker image
is initialized by ansible.

## Playbooks

There are three playbooks:

- `dpdk_devel` - installs Docker image useful for development and experimenting
- `dpdk_runtime` - installs Docker image with runtime only (as small as possible)
- `training_machine` - prepares a real machine intended for playing with docker images

## Helper scripts

In ansible role `helper-scripts`, there are two scripts: `in-docker` and `in-container`.
Install them into your system (via `training_machine` playbook or manually) to be accessible.
They are intended to be used with Docker images and containres. It is possible to e.g.
start a DPDK application as:

```
$ in-docker my-dpdk-service
```

while in another terminal, it is possible to connect into the running container (named `dpdk`):

```
$ in-container dpdk-telemetry.py
```
