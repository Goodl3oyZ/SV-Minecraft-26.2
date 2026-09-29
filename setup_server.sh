#!/usr/bin/env bash
# Minecraft Fabric Server Setup Script for Linux (MC 26.2 - Java & Bedrock Cross-Play Enabled)
set -e

SERVER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SERVER_DIR"

echo "=========================================="
echo "  Minecraft Fabric Server Setup (Linux)   "
echo "  Minecraft Version: 26.2 (Cross-Play)    "
echo "=========================================="

# Step 1: Clean old files except repository scripts
echo "[1/6] Cleaning old runtime files..."
find . -mindepth 1 -maxdepth 1 \
  ! -name 'setup_server.sh' \
  ! -name 'start_server.sh' \
  ! -name 'backup_world.sh' \
  ! -name 'README.md' \
  ! -name '.gitignore' \
  ! -name '.git' \
  -exec rm -rf {} + 2>/dev/null || true

# Step 2: Download Fabric Server Jar for 26.2
echo "[2/6] Downloading Fabric Server JAR (MC 26.2)..."
curl -sSL "https://meta.fabricmc.net/v2/versions/loader/26.2/0.19.5/1.1.2/server/jar" -o fabric-server-launch.jar
echo "  Downloaded fabric-server-launch.jar!"

# Step 3: Download Mods (Fabric API, Lithium, Geyser-Fabric)
echo "[3/6] Installing mods (Fabric API, Lithium, Geyser-Fabric)..."
mkdir -p mods

# Fabric API for 26.2
echo "  Downloading Fabric API for MC 26.2..."
FABRIC_API_URL=$(curl -sSL "https://api.modrinth.com/v2/project/fabric-api/version?game_versions=%5B%2226.2%22%5D&loaders=%5B%22fabric%22%5D" | grep -o '"url":"[^"]*"' | head -n 1 | cut -d'"' -f4 || true)
if [ -z "$FABRIC_API_URL" ]; then
    FABRIC_API_URL=$(curl -sSL "https://api.modrinth.com/v2/project/fabric-api/version" | grep -o '"url":"[^"]*"' | head -n 1 | cut -d'"' -f4)
fi
curl -sSL "$FABRIC_API_URL" -o mods/fabric-api.jar

# Lithium for 26.2
echo "  Downloading Lithium for MC 26.2..."
LITHIUM_URL=$(curl -sSL "https://api.modrinth.com/v2/project/lithium/version?game_versions=%5B%2226.2%22%5D&loaders=%5B%22fabric%22%5D" | grep -o '"url":"[^"]*"' | head -n 1 | cut -d'"' -f4 || true)
if [ -z "$LITHIUM_URL" ]; then
    LITHIUM_URL=$(curl -sSL "https://api.modrinth.com/v2/project/lithium/version" | grep -o '"url":"[^"]*"' | head -n 1 | cut -d'"' -f4)
fi
curl -sSL "$LITHIUM_URL" -o mods/lithium.jar

# Geyser-Fabric (Bedrock Cross-Play)
echo "  Downloading Geyser-Fabric (Bedrock Cross-Play)..."
curl -sSL "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/fabric" -o mods/Geyser-Fabric.jar

echo "  Mods installed into /mods!"

# Step 4: Create eula.txt
echo "[4/6] Creating eula.txt..."
echo "eula=true" > eula.txt

# Step 5: Generate server.properties
echo "[5/6] Generating server.properties..."
cat << 'EOF' > server.properties
# Minecraft Server Properties
difficulty=normal
enable-command-block=true
gamemode=survival
level-name=world
max-players=20
motd=\u00A7b\u00A7lFabric Minecraft Server \u00A77(26.2)\u00A7r\n\u00A7eJava + Bedrock (PE) Cross-Play Enabled
network-compression-threshold=256
online-mode=true
pvp=true
server-port=25565
simulation-distance=8
view-distance=10
EOF

# Step 6: Make scripts executable
echo "[6/6] Setting executable permissions..."
chmod +x start_server.sh 2>/dev/null || true
chmod +x backup_world.sh 2>/dev/null || true

echo "=========================================="
echo "  Fabric Server Setup Completed!"
echo "  Minecraft Version: 26.2"
echo "  Java Port:    25565 (TCP)"
echo "  Bedrock Port: 19132 (UDP)"
echo "=========================================="
