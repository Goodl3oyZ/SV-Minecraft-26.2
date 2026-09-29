@echo off
title Fabric Minecraft Server 26.3 (4GB RAM)
color 0A

:start
echo ========================================================
echo   Starting Minecraft Fabric Server 26.3 (4GB RAM)
echo   Java Executable: java
echo ========================================================
echo.

java -Xms4G -Xmx4G ^
  -XX:+UseG1GC ^
  -XX:+ParallelRefProcEnabled ^
  -XX:MaxGCPauseMillis=200 ^
  -XX:+UnlockExperimentalVMOptions ^
  -XX:+DisableExplicitGC ^
  -XX:+AlwaysPreTouch ^
  -XX:G1NewSizePercent=30 ^
  -XX:G1MaxNewSizePercent=40 ^
  -XX:G1HeapRegionSize=8M ^
  -XX:G1ReservePercent=20 ^
  -XX:G1HeapWastePercent=5 ^
  -XX:G1MixedGCCountTarget=4 ^
  -XX:InitiatingHeapOccupancyPercent=15 ^
  -XX:G1MixedGCLiveThresholdPercent=90 ^
  -XX:G1RSetUpdatingPauseTimePercent=5 ^
  -XX:SurvialRatio=8 ^
  -jar fabric-server-launch.jar nogui

echo.
echo ========================================================
echo   Server stopped! Restarting in 5 seconds...
echo   Press CTRL+C to cancel auto-restart.
echo ========================================================
timeout /t 5 /nobreak
goto start
