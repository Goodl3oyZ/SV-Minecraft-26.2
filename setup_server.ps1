# Setup script for Minecraft Fabric Server (MC 26.3)
$ErrorActionPreference = "Stop"

$ServerDir = "c:\Users\panud\OneDrive\Desktop\This is Server Minecraft"
Set-Location $ServerDir

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Minecraft Fabric Server Clean Setup    " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Step 1: Clean existing directory contents except script itself
Write-Host "`n[1/6] Cleaning old server files and folders..." -ForegroundColor Yellow
$itemsToKeep = @("setup_server.ps1")
Get-ChildItem -Path $ServerDir | ForEach-Object {
    if ($itemsToKeep -notcontains $_.Name) {
        Write-Host "  Removing: $($_.Name)" -ForegroundColor Gray
        Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
}
Write-Host "  Cleanup completed successfully!" -ForegroundColor Green

# Step 2: Download Fabric Server Jar
Write-Host "`n[2/6] Downloading Fabric Server JAR (MC 26.3, Loader 0.19.5, Installer 1.1.2)..." -ForegroundColor Yellow
$fabricJarUrl = "https://meta.fabricmc.net/v2/versions/loader/26.3/0.19.5/1.1.2/server/jar"
$targetJar = Join-Path $ServerDir "fabric-server-launch.jar"
Invoke-WebRequest -Uri $fabricJarUrl -OutFile $targetJar
Write-Host "  Downloaded fabric-server-launch.jar successfully!" -ForegroundColor Green

# Step 3: Download Mods (Fabric API & Lithium)
Write-Host "`n[3/6] Installing essential mods (Fabric API & Lithium)..." -ForegroundColor Yellow
$modsDir = Join-Path $ServerDir "mods"
New-Item -ItemType Directory -Path $modsDir -Force | Out-Null

# Fabric API
try {
    Write-Host "  Fetching Fabric API from Modrinth..." -ForegroundColor Gray
    $modrinthApiUrl = "https://api.modrinth.com/v2/project/fabric-api/version"
    $versions = Invoke-RestMethod -Uri $modrinthApiUrl
    $match = $versions | Where-Object { $_.game_versions -contains "26.3" -and $_.loaders -contains "fabric" } | Select-Object -First 1
    if (-not $match) { $match = $versions[0] }
    $fileUrl = $match.files[0].url
    $fileName = $match.files[0].filename
    Write-Host "  Downloading Fabric API: $fileName" -ForegroundColor Gray
    Invoke-WebRequest -Uri $fileUrl -OutFile (Join-Path $modsDir $fileName)
} catch {
    Write-Host "  Warning: Failed to auto-download Fabric API: $_" -ForegroundColor Red
}

# Lithium
try {
    Write-Host "  Fetching Lithium from Modrinth..." -ForegroundColor Gray
    $modrinthApiUrl = "https://api.modrinth.com/v2/project/lithium/version"
    $versions = Invoke-RestMethod -Uri $modrinthApiUrl
    $match = $versions | Where-Object { $_.game_versions -contains "26.3" -and $_.loaders -contains "fabric" } | Select-Object -First 1
    if (-not $match) { $match = $versions[0] }
    $fileUrl = $match.files[0].url
    $fileName = $match.files[0].filename
    Write-Host "  Downloading Lithium: $fileName" -ForegroundColor Gray
    Invoke-WebRequest -Uri $fileUrl -OutFile (Join-Path $modsDir $fileName)
} catch {
    Write-Host "  Warning: Failed to auto-download Lithium: $_" -ForegroundColor Red
}

Write-Host "  Mods installed into /mods!" -ForegroundColor Green

# Step 4: Create eula.txt
Write-Host "`n[4/6] Creating eula.txt..." -ForegroundColor Yellow
$eulaContent = @"
# By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).
# $(Get-Date)
eula=true
"@
Set-Content -Path (Join-Path $ServerDir "eula.txt") -Value $eulaContent
Write-Host "  eula.txt created (eula=true)!" -ForegroundColor Green

# Step 5: Create server.properties
Write-Host "`n[5/6] Generating modern server.properties..." -ForegroundColor Yellow
$serverProperties = @"
# Minecraft Server Properties
# Generated on $(Get-Date)
accepts-transfers=false
allow-flight=false
allow-nether=true
broadcast-console-to-ops=true
broadcast-rcon-to-ops=true
bug-report-link=
difficulty=normal
enable-command-block=true
enable-jmx-monitoring=false
enable-query=false
enable-rcon=false
enable-status=true
enforce-secure-profile=true
enforce-whitelist=false
entity-broadcast-range-percentage=100
force-gamemode=false
function-permission-level=2
gamemode=survival
generate-structures=true
generator-settings={}
hardcore=false
hide-online-players=false
initial-disabled-packs=
initial-enabled-packs=vanilla
level-name=world
level-seed=
level-type=minecraft\:normal
log-ips=true
max-chained-neighbor-updates=1000000
max-players=20
max-tick-time=60000
max-world-size=29999984
motd=\u00A7b\u00A7lFabric Minecraft Server \u00A77(26.3)\u00A7r\n\u00A7eClean Modern Setup - 4GB RAM
network-compression-threshold=256
online-mode=true
op-permission-level=4
player-idle-timeout=0
prevent-proxy-connections=false
pvp=true
query.port=25565
rate-limit=0
rcon.password=
rcon.port=25575
region-file-compression=deflate
require-resource-pack=false
resource-pack=
resource-pack-id=
resource-pack-prompt=
resource-pack-sha1=
server-ip=
server-port=25565
simulation-distance=8
spawn-animals=true
spawn-monsters=true
spawn-npcs=true
spawn-protection=16
sync-chunk-writes=true
use-native-transport=true
view-distance=10
white-list=false
"@
Set-Content -Path (Join-Path $ServerDir "server.properties") -Value $serverProperties
Write-Host "  server.properties generated!" -ForegroundColor Green

# Step 6: Create Start-Server.bat & Backup-World.bat
Write-Host "`n[6/6] Creating start and management batch scripts..." -ForegroundColor Yellow

$startBatContent = @"
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
"@
Set-Content -Path (Join-Path $ServerDir "Start-Server.bat") -Value $startBatContent

$backupBatContent = @"
@echo off
title Minecraft Server Backup Utility
color 0B
echo ========================================================
echo   Minecraft World Backup Script
echo ========================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "^
    `$date = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'; ^
    `$backupDir = Join-Path (Get-Location) 'backups'; ^
    if (-not (Test-Path `$backupDir)) { New-Item -ItemType Directory -Path `$backupDir | Out-Null }; ^
    `$zipPath = Join-Path `$backupDir (\"world-backup-\" + `$date + \".zip\"); ^
    if (Test-Path 'world') { ^
        Write-Host '[INFO] Creating backup:' `$zipPath -ForegroundColor Cyan; ^
        Compress-Archive -Path 'world' -DestinationPath `$zipPath -CompressionLevel Optimal; ^
        Write-Host '[SUCCESS] Backup complete!' -ForegroundColor Green; ^
    } else { ^
        Write-Host '[WARNING] No world folder found to backup yet.' -ForegroundColor Yellow; ^
    } ^
"

echo.
pause
"@
Set-Content -Path (Join-Path $ServerDir "Backup-World.bat") -Value $backupBatContent

$howToPlayContent = @"
@echo off
title Server Information & How to Play
color 0F
cls
echo ========================================================
echo           MINECRAFT FABRIC SERVER 26.3
echo ========================================================
echo.
echo  Server Software: Fabric Server 26.3
echo  RAM Allocated:   4 GB
echo  Port:            25565
echo.
echo  How to connect:
echo  1. Start the server using 'Start-Server.bat'
echo  2. Open Minecraft Launcher and select Minecraft 26.3
echo  3. Go to Multiplayer -> Direct Connect / Add Server
echo  4. Server Address: localhost (or your local IP)
echo.
echo  Utility Scripts:
echo   - Start-Server.bat  : Launches server with optimized JVM flags
echo   - Backup-World.bat : Creates timestamped ZIP backup in /backups
echo.
echo ========================================================
pause
"@
Set-Content -Path (Join-Path $ServerDir "HOW-TO-PLAY.bat") -Value $howToPlayContent

Write-Host "  Batch scripts generated!" -ForegroundColor Green

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "  Fabric Server Setup Completed Successfully!" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
