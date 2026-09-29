@echo off
title Minecraft Server Backup Utility
color 0B
echo ========================================================
echo   Minecraft World Backup Script
echo ========================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "^
    $date = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'; ^
    $backupDir = Join-Path (Get-Location) 'backups'; ^
    if (-not (Test-Path $backupDir)) { New-Item -ItemType Directory -Path $backupDir | Out-Null }; ^
    $zipPath = Join-Path $backupDir (\"world-backup-\" + $date + \".zip\"); ^
    if (Test-Path 'world') { ^
        Write-Host '[INFO] Creating backup:' $zipPath -ForegroundColor Cyan; ^
        Compress-Archive -Path 'world' -DestinationPath $zipPath -CompressionLevel Optimal; ^
        Write-Host '[SUCCESS] Backup complete!' -ForegroundColor Green; ^
    } else { ^
        Write-Host '[WARNING] No world folder found to backup yet.' -ForegroundColor Yellow; ^
    } ^
"

echo.
pause
