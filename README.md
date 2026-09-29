# 🐧 Minecraft Fabric Server 26.2 (Pure Linux Template)

สคริปต์ติดตั้งและรันเซิร์ฟเวอร์ **Minecraft Fabric (เวอร์ชัน 26.2)** สำหรับ **Linux Server / VPS** (Ubuntu / Debian / CentOS) รองรับการเล่นข้ามแพลตฟอร์ม **Java (คอม) + Bedrock (มือถือ/PE)** ด้วย `Geyser-Fabric` พร้อมสคริปต์สำรองข้อมูลและคู่มือการรันเบื้องหลังด้วย `playit.gg`, `screen` และ `Cronjob`

---

## 🛠️ สิ่งที่ต้องมีก่อนเริ่ม (Requirements)

- **OS**: Linux Server (Ubuntu 20.04/22.04/24.04, Debian 11/12, CentOS 8/9, RHEL)
- **Java**: **Java 25** (OpenJDK 25)
- **RAM**: อย่างน้อย 4 GB

---

## 📖 ขั้นตอนที่ 1: ติดตั้ง Java 25 บน Linux

```bash
# 1. ดาวน์โหลด OpenJDK 25 อัตโนมัติจาก Adoptium
curl -sSL "https://api.adoptium.net/v3/binary/latest/25/ga/linux/x64/jdk/hotspot/normal/eclipse" -o openjdk25.tar.gz

# 2. แตกไฟล์ไว้ที่ /opt/jdk-25
mkdir -p /opt/jdk-25
tar -xzf openjdk25.tar.gz -C /opt/jdk-25 --strip-components=1
rm openjdk25.tar.gz

# 3. ตรวจสอบเวอร์ชัน Java 25
/opt/jdk-25/bin/java -version
```

---

## 🚀 ขั้นตอนที่ 2: ติดตั้งและสร้างเซิร์ฟเวอร์ Minecraft 26.2

```bash
# 1. Clone Repository
git clone https://github.com/Goodl3oyZ/SV-Minecraft-26.3.git
cd SV-Minecraft-26.3

# 2. ให้สิทธิ์สคริปต์และรัน setup
chmod +x setup_server.sh start_server.sh backup_world.sh
./setup_server.sh
```

---

## 🌐 ขั้นตอนที่ 3: ติดตั้งและตั้งค่า playit.gg ให้รันเบื้องหลัง (Background Service)

เพื่อเปิดพอร์ตให้เพื่อนเข้าเล่นโดยไม่ต้องทำ Port Forwarding และรันเบื้องหลังตลอดเวลา:

### 1. ติดตั้ง playit บน Linux
```bash
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/playit.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | tee /etc/apt/sources.list.d/playit.list
apt update && apt install playit -y
```

### 2. ผูก Secret Key และสั่งเปิดบริการเบื้องหลังอัตโนมัติ (Background Service)
```bash
# ผูกกับ Secret Key ที่ได้จากบนเว็บ playit.gg
playit secret <ใส่_SECRET_KEY_ที่ก๊อปมาตรงนี้>

# สั่งให้ playit ทำงานเป็นบริการเบื้องหลัง (Background Service) 24 ชม.
systemctl enable --now playit
```

---

## 🎮 ขั้นตอนที่ 4: เปิดเซิร์ฟเวอร์ Minecraft เบื้องหลังด้วย `screen`

```bash
# 1. ติดตั้งโปรแกรม screen
apt install screen -y

# 2. เปิดเซิร์ฟเวอร์ในหน้าจอเบื้องหลังชื่อ mc-server
cd ~/SV-Minecraft-26.3
screen -S mc-server ./start_server.sh
```

- **ออกจากหน้าจอ**: กด `Ctrl + A` แล้วตามด้วย `D`
- **กลับเข้าหน้าจอ**: `screen -r mc-server`

---

## ⏰ ขั้นตอนที่ 5: ตั้งค่า Cronjob สำรองข้อมูลแมพ (Backup) อัตโนมัติทุกวัน

คุณสามารถตั้งค่าให้ระบบรันสคริปต์ `backup_world.sh` เพื่อบีบอัดแมพเก็บไว้อัตโนมัติทุกๆ วัน (เช่น เวลาตี 4):

### 1. เปิดไฟล์ตั้งค่า Cronjob ของเครื่อง Linux
```bash
crontab -e
```

### 2. เพิ่มบรรทัดนี้ไว้ด้านล่างสุดของไฟล์ แล้วกด Save
```cron
0 4 * * * /bin/bash /root/SV-Minecraft-26.3/backup_world.sh > /dev/null 2>&1
```
*(คำสั่งด้านบนจะรันสคริปต์สำรองข้อมูลแมพลงโฟลเดอร์ `/backups` อัตโนมัติในเวลา 04:00 น. ของทุกวัน)*

---

## 💾 วิธีการสั่งสำรองข้อมูลด้วยตนเอง (Manual Backup)

```bash
./backup_world.sh
```
ไฟล์บีบอัดจะจัดเก็บไว้ที่ `backups/world-backup-YYYY-MM-DD_HH-mm-ss.zip`
