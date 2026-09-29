# 🎮 Minecraft Fabric Server 26.3 (Clean Setup Template)

แม่แบบติดตั้งและตั้งค่าเซิร์ฟเวอร์ **Minecraft Fabric (เวอร์ชัน 26.3)** อัตโนมัติ พร้อมสคริปต์ปรับแต่งประสิทธิภาพและระบบสำรองข้อมูลแมพแบบวันคลิก

---

## 🚀 จุดเด่น (Features)

- **⚡ ติดตั้งอัตโนมัติในคำสั่งเดียว**: ใช้สคริปต์ `setup_server.ps1` สำหรับดาวน์โหลด Fabric Server 26.3 และมอดจำเป็นให้อัตโนมัติ
- **🔥 มาพร้อมมอดเพิ่มประสิทธิภาพ**:
  - `Fabric API` (มอดพื้นฐานสำหรับสถาปัตยกรรม Fabric)
  - `Lithium` (มอดเพิ่มประสิทธิภาพ Tick rate & Server Performance)
- **⚙️ สคริปต์รันเซิร์ฟเวอร์แบบปรับแต่ง (`Start-Server.bat`)**:
  - กำหนด RAM 4GB (`-Xms4G -Xmx4G`)
  - ใช้ **Aikar's G1GC Flags** เพื่อลดอาการกระตุกจาก Garbage Collection
  - ระบบ **Auto-Restart Loop** รันเซิร์ฟเวอร์ใหม่อัตโนมัติเมื่อเกิดการ Crash หรือหลุด
- **📦 ระบบสำรองข้อมูลแมพ (`Backup-World.bat`)**: สำรองข้อมูลโฟลเดอร์ `world` เป็นไฟล์ `.zip` พร้อมประทับวันเวลาเก็บลงในโฟลเดอร์ `/backups`
- **🛡️ พร้อมสำหรับ GitHub**: กรองไฟล์ขยะและไฟล์ขนาดใหญ่ทิ้งด้วย `.gitignore` ที่ตั้งค่ามาเป็นอย่างดี

---

## 🛠️ สิ่งที่ต้องมีก่อนเริ่ม (Requirements)

- **Java**: Java 21 ขึ้นไป (แนะนำ Java 21 LTS หรือ Java 25)
- **RAM**: หน่วยความจำอย่างน้อย 4 GB
- **OS**: Windows 10 / 11

---

## 📖 ขั้นตอนการใช้งาน (How to Use)

### 1. Clone Repository นี้ลงเครื่อง
```bash
git clone https://github.com/Goodl3oyZ/SV-Minecraft-26.3.git
cd SV-Minecraft-26.3
```

### 2. รันสคริปต์ติดตั้งเซิร์ฟเวอร์ (ครั้งแรกครั้งเดียว)
คลิกขวาเปิด PowerShell หรือใช้ Command Prompt แล้วพิมพ์คำสั่ง:
```powershell
powershell -ExecutionPolicy Bypass -File .\setup_server.ps1
```
> สคริปต์จะทำการดาวน์โหลดไฟล์ `fabric-server-launch.jar`, มอด `Fabric API`, มอด `Lithium`, ยอมรับ EULA (`eula=true`) และสร้างไฟล์ `server.properties` ให้อัตโนมัติ

### 3. เปิดเซิร์ฟเวอร์เข้าเล่น
ดับเบิ้ลคลิกไฟล์ **`Start-Server.bat`** เพื่อเปิดเซิร์ฟเวอร์

- **Server IP (สำหรับคนเปิด)**: `localhost:25565`
- **Server IP (สำหรับเพื่อนในวง LAN เดียวกัน)**: `<IPv4-Address>:25565`

---

## 📂 โครงสร้างไฟล์ในโปรเจกต์

| ไฟล์ / โฟลเดอร์ | รายละเอียด |
| :--- | :--- |
| `setup_server.ps1` | สคริปต์หลักสำหรับติดตั้ง/ดาวน์โหลดเซิร์ฟเวอร์และมอด |
| `Start-Server.bat` | ปุ่มกดเปิดเซิร์ฟเวอร์ (พร้อม G1GC Flags & Auto-Restart) |
| `Backup-World.bat` | ปุ่มกดสแอปสำรองข้อมูลแมพลงโฟลเดอร์ `/backups` |
| `HOW-TO-PLAY.bat` | ปุ่มกดเช็ครายละเอียดพอร์ตและวิธีเข้าเล่น |
| `server.properties` | ไฟล์กำหนดค่าเซิร์ฟเวอร์ Minecraft |
| `eula.txt` | ไฟล์ข้อตกลงการใช้งาน (`eula=true`) |
| `config/` | โฟลเดอร์การตั้งค่ามอด (เช่น Lithium) |
| `.gitignore` | กรองไฟล์แมพ, ไฟล์ JAR และ Logs ไม่ให้อัปโหลดขึ้น Git |

---

## 💾 วิธีการสำรองข้อมูล (Backup World)

เมื่อต้องการสำรองข้อมูลแมพ ให้ดับเบิ้ลคลิกที่ไฟล์ **`Backup-World.bat`** ระบบจะสร้างไฟล์บีบอัดไว้ที่:
```
backups/world-backup-YYYY-MM-DD_HH-mm-ss.zip
```

---

## 📝 License & Credits
- **Minecraft**: © Mojang AB
- **Fabric**: FabricMC Team ([fabricmc.net](https://fabricmc.net))
- **Lithium**: CaffeineMC Team
