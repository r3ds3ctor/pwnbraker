
<img width="839" alt="Screenshot 2025-04-01 at 1 29 16 PM" src="https://github.com/user-attachments/assets/4dd33276-00b5-4b15-8c3e-4678826d5f54" />



A powerful Linux privilege escalation reconnaissance tool built for red teamers, penetration testers, and security researchers. It analyzes a Linux system to identify weaknesses, misconfigurations, and known escalation vectors. All in one automated script.

>  Break barriers. Pwn systems. Become root.

---

##  Features

- 🔍 Full privilege escalation scan on Linux systems
- 🛠 Checks for SUID/SGID binaries, capabilities, misconfigurations, writable paths, and more
- 🌐 GTFOBins enumeration for exploitable binaries
- 🔒 Kernel version check with optional SearchSploit lookup
- ⚙️ Sudo permission analysis
- 🧬 Docker/LXC container detection
- 🔐 SSH key hunting and sensitive file access checks
- 📊 Progress bar included to show analysis status
- 📁 Generates a complete audit report (`privilege_escalation_report.txt`)
- 💥 Optional built-in escalation attempt via sudo

---

## 📦 Installation

```
git clone https://github.com/yourusername/PwnBraker.git
cd PwnBraker
chmod +x pwnb.sh
```
Dependencies (optional):

- curl

- getcap

- netstat

- searchsploit (optional for kernel CVE lookup)

Install with:
```
sudo apt install curl net-tools libcap2-bin exploitdb -y
```
## 🧪 Usage
```
./pwnb.sh
```
The script will:

- Display a progress bar while scanning the system

- Analyze the environment for common privilege escalation vectors

- Save a full report to privilege_escalation_report.txt

- Optionally prompt for a real privilege escalation attempt

## Output

<img width="602" alt="Screenshot 2025-04-01 at 12 05 22 PM" src="https://github.com/user-attachments/assets/1a4de8d2-2ab5-402f-86b3-0c2b038970a1" />




https://github.com/user-attachments/assets/f46f6f8f-481e-4219-931e-41a45db7735e


## Contributting

Contributions are welcome! If you have ideas for new checks, improvements, or bug fixes, feel free to:

- Open an issue

- Submit a pull request

- Share the tool with fellow hackers

## Requirements.txt (optional)
```
curl
net-tools
libcap2-bin
exploitdb
```

## 📄 License
This project is licensed under the MIT License.

## Author
Developed by [Alexander B]
Founder of Cyber Sector | Red Teamer | Fullstack Builder | Security Disruptor

☕ Support the project: buymeacoffee.com/alexboteroh

## ⚠️ Disclaimer
This tool is provided for educational and authorized security testing purposes only. Unauthorized use of this tool against systems you do not own or have explicit permission to test is illegal and unethical.

## 🔓 PwnBraker
Escalate intelligently. Break systems ethically. Become the root of power.
