#!/bin/bash
set -e

# Atualizar sistema
apt-get update && apt-get upgrade -y

# Instalar Docker
curl -fsSL https://get.docker.com | sh
usermod -aG docker ubuntu

# Instalar Docker Compose
apt-get install -y docker-compose-plugin

# Criar diretórios
mkdir -p /opt/mail/stalwart_data
mkdir -p /opt/mail/bulwark_data
cd /opt/mail

# Criar docker-compose.yml
cat > docker-compose.yml << 'EOF'
services:
  stalwart:
    image: stalwartlabs/stalwart:latest
    container_name: stalwart
    restart: unless-stopped
    ports:
      - "25:25"
      - "587:587"
      - "993:993"
      - "8080:8080"
    volumes:
      - ./stalwart_data:/opt/stalwart
    networks:
      - mail

  bulwark:
    image: ghcr.io/bulwarkmail/webmail:latest
    container_name: bulwark
    restart: unless-stopped
    ports:
      - "3000:3000"
    volumes:
      - ./bulwark_data:/app/data/admin
    environment:
      - JMAP_SERVER_URL=http://stalwart:8080
    depends_on:
      - stalwart
    networks:
      - mail

networks:
  mail:
    driver: bridge
EOF

# Subir os containers
docker compose up -d

# Aguardar e mostrar credenciais
sleep 15
echo "=== Credenciais do Stalwart ==="
docker logs stalwart 2>&1 | grep -i "admin\|password" || echo "Verifique os logs: docker logs stalwart"