# docker-calibre-content-server

Provides a base calibre install which exposes the calibre-content server via port $PORT.

This is primarily useful to me, as I also run [calibre-web](), but still have some services that require the content-server to be available, and most of the current options for calibre containers are quite heavy due to needing to support the entire calibre GUI.

## Running

### docker

Can be run with the following:

```sh
docker run -d --name=calibre -v /home/books:/data:Z -p 8080:8080 bcleonard/calibre
```

### docker-compose

```yaml
services:
  calibre:
    build: .
    restart: always
    volumes:
      - ./books:/data/library
    ports:
      - 8080:8080
    user: 1000:1000
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
```

Also see [sample](./docker-compose.yml) compose file.

## Credits

- Forked from [bcleonard/calibre]()

# ORIGINAL README

---

# calibre

This contains the docker file and all necessary files to build a docker container for calibre.

Calibre (https://calibre-ebook.com) is probably the best e-book management system out there. This docker container will run the server portion only.

## Preperation

Before running the container, you'll need to have the following directories predefined on the container host:

```sh
library
addbooks
```

The library directory will hold your books & database. addbooks will be used to add books to your library. I used:

```sh
/home/books/library
/home/books/addbooks
```

for the instructions below. Just make sure you create them prior to starting the container.

## To run the container:

```sh
docker run -d --name=calibre -v /home/books:/data:Z -p 8080:8080 bcleonard/calibre
```

## To access Calibre:

```sh
http://<docker_host>:8080
```

## To add books to the library.

First add your books to /home/books/addbooks, one book (all formats) per directory. Then run the following command:

```sh
docker exec calibre /scripts/add-books.sh
```

All the books in /home/books/addbooks will be added to the library, removed from the /home/books/addbooks directory and calibre notified.

To remove books from the library:

```sh
docker exec calibre /scripts/remove-books.sh -i <book_id>
```

## Notes/Caveats/Issues:

- I recommend running the add-scripts.sh ad-hoc, when necessary. You can schedule it via the host (via cron, etc).
- I recommend that you only pull versioned containers, not latest.
