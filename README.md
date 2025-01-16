# docker-calibre-content-server

Provides a base calibre install which exposes the calibre-content server via port $PORT.

This is primarily useful to me, as I also run [calibre-web](), but still have some services that require the content-server to be available, and most of the current options for calibre containers are quite heavy due to needing to support the entire calibre GUI.

## Features

Supports the following features:

- [ ] Runs calibre content server with the following features
  - [x] Custom port (via `PORT`)
  - [ ] Auth (via `USERNAME` & `PASSWORD` env vars)
- [ ] Mountable `/config` directory

### Env Vars

All env vars are optional.
| Name | Default | Description |
|---|---|---|
| `PORT` | `8080` | Contains [startup](./startup.sh) script and config files |
| `ENABLE_AUTH` | | Any value here will enable auth (requires `USERNAME` & `PASSWORD`)|
| `USERNAME` | `user` | Username for web auth|
| `PASSWORD` | `password` | Password for web auth |

### Volumes

| Name    | Required | Description                                      |
| ------- | -------- | ------------------------------------------------ |
| `/data` | X        | Calibre library containing books & `metadata.db` |

## Running

### docker

Can be run with the following:

```sh
# Optionally build
docker build . -t ghcr/Pete-Hamlin/calibre-content-server
docker run -d --name=calibre -v /home/books:/data -p 8080:8080
```

### docker-compose

```yaml
services:
  calibre:
    build: .
    restart: always
    volumes:
      - /path/to/books:/data
      - /path/to/config:/config # optional
    ports:
      - 8080:8080
    user: 1000:1000
    environment:
      - PORT=8080
      - ENABLE_AUTH=1 # optional
      - USERNAME=user # optional
      - PASSWORD=pass # optional
```

Also see [sample](./docker-compose.yml) compose file.

## Credits

- Forked from [bcleonard/calibre]()

---

## References

- [Calibre Manual - Server](https://manual.calibre-ebook.com/server.html)
- [Calibre Manual - Customize](https://manual.calibre-ebook.com/customize.html)
- [linuxserver/calibre](https://github.com/linuxserver/docker-calibre)
