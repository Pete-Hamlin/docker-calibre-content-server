# calibre

This contains the docker file and all necessary files to build a docker container for calibre.

Calibre (https://calibre-ebook.com) is probably the best e-book management system out there.  This docker container will run the server portion only.

### Preperation

Before running the container, you'll need to have the following directories predefined on the container host:
```sh
library
addbooks
```
The library directory will hold your books & database.  addbooks will be used to add books to your library.  I used:
```sh
/home/books/library
/home/books/addbooks
```
for the instructions below.  Just make sure you create them prior to starting the container.

### To run the container:

```sh
docker run -d --name=calibre -v /home/books:/data:Z -p 8080:8080 bcleonard/calibre
```

### To access Calibre:

```sh
http://<docker_host>:8080
```

### To add books to the library.  

First add your books to /home/books/addbooks, one book (all formats) per directory.  Then run the following command:
```sh
docker exec calibre /scripts/add-books.sh
```
All the books in /home/books/addbooks will be added to the library, removed from the /home/books/addbooks directory and calibre notified.

To remove books from the library:

```sh
docker exec calibre /scripts/remove-books.sh -i <book_id>
```

### Notes/Caveats/Issues:

1.	I recommend running the add-scripts.sh ad-hoc, when necessary.  You can schedule it via the host (via cron, etc).
2.	I recommend that you only pull versioned containers, not latest.  

