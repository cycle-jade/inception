*This project has been created as part of the 42 curriculum by glicciar.*

## Description

Inception is a system administration project that uses Docker to virtualize a small infrastructure. The goal is to set up a working environment composed of multiple services running in separate Docker containers, orchestrated with Docker Compose inside a Virtual Machine.

The infrastructure includes:
- An NGINX container with TLSv1.2/TLSv1.3 only
- A WordPress + php-fpm container
- A MariaDB container
- Two Docker volumes (database and website files)
- A Docker network connecting all containers

## Instructions

### Requirements
- Docker and Docker Compose installed
- Make installed
- A Virtual Machine running Debian

### Installation
```bash
git clone https://github.com/cycle-jade/inception.git
cd inception
cp .env.example srcs/.env
# Edit srcs/.env and the nginx server_name before starting the services.
make
```

### Usage
- Start: `make`
- Stop: `make down`
- Clean: `make clean`
- Full reset: `make fclean`
- Rebuild: `make re`

### Access
- Website: https://yourlogin.42.fr
- Admin panel: https://yourlogin.42.fr/wp-admin

## Design Choices

### Virtual Machines vs Docker
A Virtual Machine emulates an entire operating system with its own kernel, making it heavy and slow to start. Docker containers share the host OS kernel and are isolated at the process level, making them lightweight and fast. We use Docker for the services and a VM as the host environment as required by the project.

### Local Configuration
The services read configuration from `srcs/.env`. Create it from `.env.example`, replace every placeholder with local values, and never commit it. The example file contains placeholders only. Set `DOMAIN_NAME` and the `server_name` in `srcs/requirements/nginx/conf/nginx.conf` to the same hostname.

### Docker Network vs Host Network
Host network mode gives containers direct access to the host's network, removing isolation. Docker bridge network (used here) isolates containers in their own network and allows them to communicate using container names as hostnames, while keeping them isolated from the outside world.

### Docker Volumes vs Bind Mounts
Bind mounts depend on the host's directory structure and are less portable. Docker named volumes are managed by Docker and more portable. We use named volumes backed by `$HOME/data` for persistent storage of WordPress files and the MariaDB database.

## Resources
- [Docker Documentation](https://docs.docker.com)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress CLI](https://wp-cli.org/)
- [MariaDB Documentation](https://mariadb.com/kb/en/)
- [PHP-FPM Documentation](https://www.php.net/manual/en/install.fpm.php)
