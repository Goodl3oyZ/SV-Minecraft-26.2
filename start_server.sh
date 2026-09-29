#!/usr/bin/env bash
# Start script for Fabric Minecraft Server (Linux)

echo "========================================================"
echo "  Starting Minecraft Fabric Server 26.3 (4GB RAM)"
echo "========================================================"
echo ""

JAVACMD="java"
if [ -f "/opt/jdk-25/bin/java" ]; then
    JAVACMD="/opt/jdk-25/bin/java"
fi

echo "Using Java binary: $JAVACMD"
$JAVACMD -version

while true; do
    $JAVACMD -Xms4G -Xmx4G \
      -XX:+UseG1GC \
      -XX:+ParallelRefProcEnabled \
      -XX:MaxGCPauseMillis=200 \
      -XX:+UnlockExperimentalVMOptions \
      -XX:+DisableExplicitGC \
      -XX:+AlwaysPreTouch \
      -XX:G1NewSizePercent=30 \
      -XX:G1MaxNewSizePercent=40 \
      -XX:G1HeapRegionSize=8M \
      -XX:G1ReservePercent=20 \
      -XX:G1HeapWastePercent=5 \
      -XX:G1MixedGCCountTarget=4 \
      -XX:InitiatingHeapOccupancyPercent=15 \
      -XX:G1MixedGCLiveThresholdPercent=90 \
      -XX:G1RSetUpdatingPauseTimePercent=5 \
      -XX:SurvivorRatio=8 \
      -jar fabric-server-launch.jar nogui

    echo ""
    echo "========================================================"
    echo "  Server stopped! Restarting in 5 seconds..."
    echo "  Press CTRL+C to cancel auto-restart."
    echo "========================================================"
    sleep 5
done
