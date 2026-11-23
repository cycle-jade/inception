# Developer Documentation

## Setting Up the Environment from Scratch

### Prerequisites
- VirtualBox with Debian 12 (bookworm) installed
- Docker and Docker Compose installed
- Make installed
- Git installed

### 1. Install Docker
```bash
sudo apt update && sudo apt install curl -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
```

### 2. Clone the repository
```bash
git clone https://github.com/cycle-jade/inception.git
cd inception
```

### 3. Configure local environment
```bash
cp .env.example srcs/.env
# Edit srcs/.env and replace every placeholder with local values.
# Set nginx server_name to match DOMAIN_NAME in srcs/.env.
```

### 4. Configure hosts file
```bash
sudo nano /etc/hosts
# Add: 127.0.0.1 yourlogin.42.fr
```

### 5. Build and launch
```bash
make
```

## Project Structure

Inception/
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── .env.example
└── srcs/
    ├── .env (create locally; never commit)
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        ├── wordpress/
        └── mariadb/

## Managing Containers

| Command | Description |
|---------|-------------|
| `make` | Build and start all containers |
| `make down` | Stop all containers |
| `make clean` | Stop and remove containers/networks |
| `make fclean` | Full reset including volumes and data |
| `make re` | Full reset and rebuild |

## Data Storage

All persistent data is stored on the VM host under `$HOME/data`:
- **MariaDB data:** `$HOME/data/mariadb`
- **WordPress files:** `$HOME/data/wordpress`

These directories are mounted as Docker named volumes and persist across container restarts.

## Useful Debug Commands

```bash
# Check running containers
docker ps

# Check container logs
docker logs <container_name>

# Enter a container
docker exec -it <container_name> bash

# Check volumes
docker volume ls
docker volume inspect <volume_name>

# Check network
docker network ls
docker network inspect srcs_inception
```
