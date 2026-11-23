# User Documentation

## What services are provided?

This stack provides a fully functional WordPress website with the following services:

- **NGINX** — Web server, the only entry point via HTTPS (port 443)
- **WordPress** — Content management system accessible via browser
- **MariaDB** — Database storing all WordPress content and users

## Starting and Stopping the Project

### Start
```bash
cd ~/inception
make
```

### Stop
```bash
make down
```

### Full reset (removes all data)
```bash
make fclean
```

## Accessing the Website

- **Website:** https://yourlogin.42.fr
- **Admin panel:** https://yourlogin.42.fr/wp-admin

> Note: A security warning will appear due to the self-signed certificate. Click "Accept the Risk and Continue" to proceed.

## Local test accounts

Set the `ADMIN_USER`, `ADMIN_PASSWORD`, `USER_LOGIN`, and `USER_PASSWORD`
values in `srcs/.env`. The committed `.env.example` contains placeholders only.
Keep `srcs/.env` local and never commit it.

## Checking Services are Running

```bash
docker ps
```

All three containers (nginx, wordpress, mariadb) should show **Up** status.

### Check individual logs
```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```
