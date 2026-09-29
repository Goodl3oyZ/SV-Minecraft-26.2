# 🐧 Minecraft Fabric Server 26.3 (Pure Linux Template)

สคริปต์ติดตั้งและรันเซิร์ฟเวอร์ **Minecraft Fabric (เวอร์ชัน 26.3)** สำหรับ **Linux Server / VPS** (Ubuntu / Debian / CentOS) รองรับการเล่นข้ามแพลตฟอร์ม **Java (คอม) + Bedrock (มือถือ/PE)** พร้อมสคริปต์สำรองข้อมูลและคำแนะนำการใช้ **playit.gg**

---

## 🛠️ สิ่งที่ต้องมีก่อนเริ่ม (Requirements)

- **OS**: Linux Server (Ubuntu 20.04/22.04/24.04, Debian 11/12, CentOS 8/9, RHEL)
- **Java**: **Java 25** (เนื่องจาก Minecraft 26.3 ต้องการ Java 25 / Class version 69.0)
- **RAM**: อย่างน้อย 4 GB

---

## 📖 ขั้นตอนการติดตั้ง Java 25 และเปิดใช้งานบน Linux LXC / VPS

### 1. ติดตั้ง Java 25 บน Linux (Adoptium / Eclipse Temurin)

```bash
# 1. ดาวน์โหลด OpenJDK 25 อัตโนมัติจาก Adoptium
curl -sSL "https://api.adoptium.net/v3/binary/latest/25/ga/linux/x64/jdk/hotspot/normal/eclipse" -o openjdk25.tar.gz

# 2. สร้างโฟลเดอร์และแตกไฟล์ไว้ที่ /opt/jdk-25
mkdir -p /opt/jdk-25
tar -xzf openjdk25.tar.gz -C /opt/jdk-25 --strip-components=1

# 3. ลบไฟล์ติดตั้งชั่วคราว
rm openjdk25.tar.gz

# 4. ตรวจสอบเวอร์ชัน Java 25
/opt/jdk-25/bin/java -version
```

---

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
```bash
./start_server.sh
```

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
