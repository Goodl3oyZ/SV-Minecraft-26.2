# 🐧 Minecraft Fabric Server 26.3 (Pure Linux Template)

สคริปต์ติดตั้งและรันเซิร์ฟเวอร์ **Minecraft Fabric (เวอร์ชัน 26.3)** สำหรับ **Linux Server / VPS** (Ubuntu / Debian / CentOS) รองรับการเล่นข้ามแพลตฟอร์ม **Java (คอม) + Bedrock (มือถือ/PE)** พร้อมสคริปต์สำรองข้อมูลและคำแนะนำการใช้ **playit.gg**

---

## 🚀 จุดเด่น (Features)

- **⚡ ติดตั้งอัตโนมัติในคำสั่งเดียว**: ใช้สคริปต์ `setup_server.sh` ดาวน์โหลด Fabric 26.3, มอด และตั้งค่า EULA ให้อัตโนมัติ
- **📱 รองรับ Cross-Play (Java + Bedrock)**: ติดตั้งมอด `Geyser-Fabric` และ `ViaVersion` ให้มือถือ (PE / iOS / Android) เข้าเล่นได้
- **🔥 มอดเพิ่มความลื่น**: ติดตั้ง `Lithium` ช่วยเพิ่ม Tick rate และลดอาการกระตุกของเซิร์ฟเวอร์
- **⚙️ สคริปต์รันเซิร์ฟเวอร์ (`start_server.sh`)**:
  - กำหนด RAM 4GB (`-Xms4G -Xmx4G`)
  - ใช้ **Aikar's G1GC Flags** ปรับแต่งการใช้หน่วยความจำ
  - ระบบ **Auto-Restart Loop** รันใหม่ให้อัตโนมัติเมื่อเกิด Crash
- **📦 ระบบสำรองข้อมูลแมพ (`backup_world.sh`)**: สำรองข้อมูลเป็นไฟล์ `.zip` พร้อมประทับเวลาใส่โฟลเดอร์ `/backups`

---

## 🛠️ สิ่งที่ต้องมีก่อนเริ่ม (Requirements)

- **OS**: Linux Server (Ubuntu 20.04/22.04/24.04, Debian 11/12, CentOS 8/9, RHEL)
- **Java**: Java 21 ขึ้นไป (เช่น OpenJDK 21 LTS)
- **RAM**: อย่างน้อย 4 GB

---

## 📖 ขั้นตอนการใช้งานบน Linux Server / VPS

### 1. ติดตั้ง Dependencies (Java 21, Curl, Zip)
```bash
sudo apt update && sudo apt install -y openjdk-21-jre-headless curl zip
```

### 2. Clone Repository
```bash
git clone https://github.com/Goodl3oyZ/SV-Minecraft-26.3.git
cd SV-Minecraft-26.3
```

### 3. รันสคริปต์ติดตั้งเซิร์ฟเวอร์ (ครั้งแรกครั้งเดียว)
```bash
chmod +x setup_server.sh start_server.sh backup_world.sh
./setup_server.sh
```

### 4. เปิดเซิร์ฟเวอร์
- **รันปกติ**:
  ```bash
  ./start_server.sh
  ```
- **รันเบื้องหลังด้วย `screen` (แนะนำสำหรับ VPS)**:
  ```bash
  screen -S mc-server ./start_server.sh
  ```
  *(กด `Ctrl + A` แล้วตามด้วย `D` เพื่อออกจากหน้าจอเบื้องหลัง)*

---

## 🌐 การเชื่อมต่อกับ playit.gg (ไม่ต้องทำ Port Forwarding)

1. **ติดตั้งและรัน playit บน Linux**:
   ```bash
   curl -sSL https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 -o playit
   chmod +x playit
   ./playit
   ```
2. **ผูกเซิร์ฟเวอร์กับเว็บ playit.gg**:
   - เปิดลิงก์ `https://playit.gg/claim/...` ที่ขึ้นใน Terminal
   - **เพิ่ม Java Tunnel**: เลือก `Minecraft Java` ➔ Local Port: `25565`
   - **เพิ่ม Bedrock Tunnel**: เลือก `Minecraft Bedrock` ➔ Local Port: `19132` (ติ๊กยอมรับ RakNet)

---

## 📂 โครงสร้างไฟล์ในโปรเจกต์

| ไฟล์ / โฟลเดอร์ | รายละเอียด |
| :--- | :--- |
| `setup_server.sh` | สคริปต์หลักสำหรับติดตั้งเซิร์ฟเวอร์และมอดบน Linux |
| `start_server.sh` | สคริปต์เปิดเซิร์ฟเวอร์ (พร้อม G1GC Flags & Auto-Restart) |
| `backup_world.sh` | สคริปต์สำรองข้อมูลแมพลงโฟลเดอร์ `/backups` |
| `server.properties` | ไฟล์กำหนดค่าเซิร์ฟเวอร์ Minecraft |
| `eula.txt` | ไฟล์ยอมรับข้อตกลงการใช้งาน (`eula=true`) |
| `.gitignore` | กรองไฟล์แมพ, JAR และ Logs ไม่ให้อัปโหลดขึ้น Git |

---

## 💾 วิธีการสำรองข้อมูล (Backup World)

```bash
./backup_world.sh
```
ไฟล์บีบอัดจะจัดเก็บไว้ที่ `backups/world-backup-YYYY-MM-DD_HH-mm-ss.zip`
