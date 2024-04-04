# Docker-Flacon
An image to run [flacon](https://github.com/flacon/flacon) in docker accesible by browser and vnc.

Based on [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui)

WebUI accesible at :5800, vnc at :5900

Run with
```docker run --rm -p 5800:5800 -p 5900:5900 -v /your-media-directory:/mediafiles ghcr.io/a-gal/docker-flacon:latest```
You should be able to access the GUI by opening
```http://[HOST IP ADDR]:5800```

If anyone is using this, `main` tag is deprecated, you can use `latest` for latest version or `v*.*.*` for specific flacon version.
