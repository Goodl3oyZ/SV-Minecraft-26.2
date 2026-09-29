#!/usr/bin/env bash
# Backup script for Minecraft world (Linux)

SERVER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SERVER_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$SERVER_DIR/backups"
mkdir -p "$BACKUP_DIR"

if [ -d "$SERVER_DIR/world" ]; then
    ZIP_PATH="$BACKUP_DIR/world-backup-$TIMESTAMP.zip"
    echo "[INFO] Creating backup: $ZIP_PATH"
    zip -r "$ZIP_PATH" world/
    echo "[SUCCESS] Backup complete!"
else
    echo "[WARNING] No world directory found to backup."
fi
