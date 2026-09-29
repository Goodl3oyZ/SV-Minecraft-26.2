# 🐧 Minecraft Fabric Server 26.2 (Pure Linux Template)

สคริปต์ติดตั้งและรันเซิร์ฟเวอร์ **Minecraft Fabric (เวอร์ชัน 26.2)** สำหรับ **Linux Server / VPS** (Ubuntu / Debian / CentOS) รองรับการเล่นข้ามแพลตฟอร์ม **Java (คอม) + Bedrock (มือถือ/PE)** ด้วย `Geyser-Fabric` พร้อมสคริปต์สำรองข้อมูลและคู่มือการรันเบื้องหลังด้วย `playit.gg` & `screen`

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
> ✨ **ข้อดี**: `playit` จะทำงานใน Background ตลอดเวลาโดยไม่แย่งหน้าจอ Terminal ของคุณ และรันให้อัตโนมัติแม้รีสตาร์ทเครื่อง Linux

---

## 🎮 ขั้นตอนที่ 4: เปิดเซิร์ฟเวอร์ Minecraft เบื้องหลังด้วย `screen`

เพื่อให้เซิร์ฟเวอร์เปิดทำงานตลอดเวลา และคุณยังคงใช้ Terminal พิมพ์คำสั่งอื่นได้ตามปกติ:

### 1. ติดตั้ง `screen`
```bash
apt install screen -y
```

### 2. เปิดหน้าจอเบื้องหลังสำหรับ Minecraft
```bash
cd ~/SV-Minecraft-26.3
screen -S mc-server ./start_server.sh
```

### 3. ออกจากหน้าจอเซิร์ฟเวอร์ (แต่เซิร์ฟเวอร์ยังรันอยู่ปกติ)
- กดคีย์บอร์ด **`Ctrl + A`** แล้วตามด้วยกด **`D`**
- คุณจะกลับมาหน้า Terminal ปกติ ใช้คำสั่งอื่นได้ทันที!

### 4. ดึงหน้าจอเซิร์ฟเวอร์กลับมาพิมพ์คำสั่ง (เช่น `/op`, `/stop`)
```bash
screen -r mc-server
```

---

## 💾 วิธีการสำรองข้อมูล (Backup World)

```bash
./backup_world.sh
```
ไฟล์บีบอัดจะจัดเก็บไว้ที่ `backups/world-backup-YYYY-MM-DD_HH-mm-ss.zip`
