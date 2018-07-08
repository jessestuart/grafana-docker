# Grafana Multiarch Docker image

[![CircleCI](https://circleci.com/gh/jessestuart/grafana-docker.svg?style=shields)](https://circleci.com/gh/jessestuart/grafana-docker)

Fork of the [official image](https://github.com/grafana/grafana-docker),
configured to automatically build multiarch images compatible with amd64,
armv7, and arm64.

Non-amd64 devices tested on:

- Rock64 (arm64, mainline 4.18 kernel)
- roc-rk3328-cc "Renegade" (arm64, self-compiled 4.4 kernel)
- Raspberry Pi 3 (arm64, HypriotOS 4.14 kernel)
- Odroid XU4 (armv7, 4.14 kernel)

-------------------------------------------------------------------------------

## Running your Grafana container

Start your container binding the external port `3000`.

```bash
docker run -d --name=grafana -p 3000:3000 grafana/grafana
```

Try it out, default admin user is admin/admin.

## How to use the container

Further documentation can be found on the [official site](http://docs.grafana.org/installation/docker/).

