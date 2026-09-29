# 🎮 Minecraft Fabric Server 26.3 (Cross-Platform Template)

แม่แบบติดตั้งและตั้งค่าเซิร์ฟเวอร์ **Minecraft Fabric (เวอร์ชัน 26.3)** อัตโนมัติ รองรับทั้ง **Windows** และ **Linux** (Ubuntu / Debian / CentOS / VPS) พร้อมสคริปต์ปรับแต่งประสิทธิภาพและระบบสำรองข้อมูลแมพ

---

## 🚀 จุดเด่น (Features)

- **🌐 รองรับแบบ Cross-Platform (Windows & Linux)**
- **⚡ ติดตั้งอัตโนมัติในคำสั่งเดียว**:
  - **Windows**: `setup_server.ps1`
  - **Linux**: `setup_server.sh`
- **🔥 มาพร้อมมอดเพิ่มประสิทธิภาพ**:
  - `Fabric API` (มอดพื้นฐานสำหรับสถาปัตยกรรม Fabric)
  - `Lithium` (มอดเพิ่มประสิทธิภาพ Tick rate & Server Performance)
- **⚙️ สคริปต์รันเซิร์ฟเวอร์แบบปรับแต่ง (`Start-Server.bat` / `start_server.sh`)**:
  - กำหนด RAM 4GB (`-Xms4G -Xmx4G`)
  - ใช้ **Aikar's G1GC Flags** เพื่อลดอาการกระตุกจาก Garbage Collection
  - ระบบ **Auto-Restart Loop** รันเซิร์ฟเวอร์ใหม่อัตโนมัติเมื่อเกิดการ Crash หรือหลุด
- **📦 ระบบสำรองข้อมูลแมพ (`Backup-World.bat` / `backup_world.sh`)**: สำรองข้อมูลโฟลเดอร์ `world` เป็นไฟล์ `.zip` พร้อมประทับวันเวลาเก็บลงในโฟลเดอร์ `/backups`

---

## 🛠️ สิ่งที่ต้องมีก่อนเริ่ม (Requirements)

- **Java**: Java 21 ขึ้นไป (แนะนำ OpenJDK 21 LTS หรือ Java 25)
- **RAM**: หน่วยความจำอย่างน้อย 4 GB
- **OS**: Windows 10/11 หรือ Linux (Ubuntu / Debian / CentOS / Alpine / RHEL)

---

## 🐧 การติดตั้งและเปิดเซิร์ฟเวอร์บน Linux (Linux VPS / Server)

### 1. ติดตั้ง Java 21 (ถ้ายังไม่มี)
```bash
# สำหรับ Ubuntu / Debian
sudo apt update && sudo apt install -y openjdk-21-jre-headless curl zip
```

### 2. Clone Repository
```bash
git clone https://github.com/Goodl3oyZ/SV-Minecraft-26.3.git
cd SV-Minecraft-26.3
```

### 3. รันสคริปต์ติดตั้งอัตโนมัติ (ครั้งแรกครั้งเดียว)
```bash
chmod +x setup_server.sh start_server.sh backup_world.sh
./setup_server.sh
```

### 4. เปิดเซิร์ฟเวอร์
- **เปิดหน้าจอปกติ**:
  ```bash
  ./start_server.sh
  ```
- **เปิดให้รันเบื้องหลังบน Linux VPS (ด้วย `screen` หรือ `nohup`)**:
  ```bash
  screen -S mc-server ./start_server.sh
  ```
  *(กด `Ctrl + A` ตามด้วย `D` เพื่อออกจากหน้าจอ screen โดยที่เซิร์ฟเวอร์ยังรันอยู่)*

---

## 🪟 การติดตั้งและเปิดเซิร์ฟเวอร์บน Windows

1. **เปิด PowerShell แล้วรันสคริปต์ติดตั้ง**:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\setup_server.ps1
   ```
2. **เปิดเซิร์ฟเวอร์**: ดับเบิ้ลคลิกไฟล์ `Start-Server.bat`

---

## 📂 โครงสร้างไฟล์ในโปรเจกต์

| ไฟล์ / โฟลเดอร์ | รายละเอียด |
| :--- | :--- |
| `setup_server.sh` / `setup_server.ps1` | สคริปต์หลักสำหรับติดตั้ง/ดาวน์โหลดเซิร์ฟเวอร์บน Linux & Windows |
| `start_server.sh` / `Start-Server.bat` | สคริปต์เปิดเซิร์ฟเวอร์ (พร้อม G1GC Flags & Auto-Restart) |
| `backup_world.sh` / `Backup-World.bat` | สคริปต์สำรองข้อมูลแมพลงโฟลเดอร์ `/backups` |
| `server.properties` | ไฟล์กำหนดค่าเซิร์ฟเวอร์ Minecraft |
| `eula.txt` | ไฟล์ข้อตกลงการใช้งาน (`eula=true`) |
| `.gitignore` | กรองไฟล์แมพ, ไฟล์ JAR และ Logs ไม่ให้อัปโหลดขึ้น Git |

---

## 💾 วิธีการสำรองข้อมูล (Backup World)

- **Linux**: `./backup_world.sh`
- **Windows**: ดับเบิ้ลคลิก `Backup-World.bat`

ไฟล์บีบอัดจะถูกจัดเก็บไว้ที่ `backups/world-backup-YYYY-MM-DD_HH-mm-ss.zip`
