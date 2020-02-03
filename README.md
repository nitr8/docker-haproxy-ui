# Info

An easy to use HAProxy-WI container...

## Quick guide

```bash
docker run -it --rm -p 80:80 -e ENABLE_STATS=TRUE -v $(PWD)/certs:/certs whumphrey/haproxy-ui
```

## TBD

```bash
docker build -t whumphrey/haproxy-ui .
docker run -it --rm -p 8088:80 whumphrey/haproxy-ui
```
