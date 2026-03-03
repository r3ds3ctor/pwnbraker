# ⚡ PwnBraker (pwnb.sh)

<img width="839" alt="Screenshot 2025-04-01 at 1 29 16 PM" src="https://github.com/user-attachments/assets/4dd33276-00b5-4b15-8c3e-4678826d5f54" />

**Practical Linux Privilege Escalation & Enumeration Script**

A powerful Linux privilege escalation reconnaissance tool built for red teamers, penetration testers, and security researchers. It analyzes a Linux system to identify weaknesses, misconfigurations, and known escalation vectors. All in one automated script.

> "Sometimes victory lies in simplicity."

PwnBraker (`pwnb.sh`) is a Bash script focused on **fast, visual, and pragmatic enumeration** for privilege escalation on Linux and Unix systems. Unlike oversized tools or over-complicated auto-exploiters, PwnBraker follows a clear philosophy: **Show you everything you need to see, and then attempt the most direct vector.**

## 🎯 Design Philosophy
In real-world pentesting and Red Team operations, automated scripts that search for "perfect" conditions often fail silently. `pwnb.sh` is designed under the principle that **the best tool is the one that doesn't fail and doesn't make assumptions**. It presents information on the screen, saves it to a report, and instead of executing a dozen unstable exploits, it intelligently attempts the most common escalation path (`sudo bash`). If it fails, it leaves you with a comprehensive report for manual exploitation.

---

## 🚀 Enumeration Modules (14 Vectors)

PwnBraker sequentially inspects the system for misconfigurations and local vectors:

1. **Kernel Version**: Displays the version (`uname -a`) to cross-reference with public exploits.
2. **SUID & SGID Binaries**: Lists binaries with the SetUID/SetGID bit enabled.
3. **Sudo Privileges**: Retrieves enabled permissions using `sudo -l`.
4. **Writable Directories**: Searches for folders where the user has write permissions at the root level (`/`).
5. **User & Group Info**: Extracts your current UID/GID context (`id`, `groups`).
6. **World-Writable Root Files**: Finds critical files owned by root but editable by others.
7. **GTFOBins Live Check**: (Online) Dynamically cross-references SUID binaries with the online GTFOBins database to detect known sudo vectors.
8. **Capabilities**: Lists critical capabilities assigned to binaries (`getcap`).
9. **Writable PATHs**: Checks if any directory in your `$PATH` is writable (Path Hijacking).
10. **Open Ports**: Reviews exposed local ports using `netstat`.
11. **Container Detection**: Identifies if you are operating inside Docker or LXC.
12. **SSH Keys**: Searches for private keys (`id_rsa`, `id_dsa`) exposed on the system.
13. **Shadow File Check**: Red alert if `/etc/shadow` is readable by your user.
14. **Local Exploit Search**: (If `searchsploit` is installed), searches for exploits applicable to the current kernel.

---

## ⚡ Exploitation (The "Hail Mary")

After finishing the visual scan and saving a clean report to `privilege_escalation_report.txt`, the script pauses and asks:

`Do you want to attempt privilege escalation? (y/n)`

If you answer `y`, PwnBraker will attempt a pure and direct vector: executing `/bin/bash` under `sudo` without a password (`sudo -n id`). If the administrator left global configurations open (like `NOPASSWD: ALL` or loose permissions), this simple attempt **will instantly drop you into an interactive root shell**.

---

## 💻 Quick Start

```bash
# Download the script
curl -O https://raw.githubusercontent.com/r3ds3ctor/pwnbraker/main/pwnb.sh

# Grant execution permissions
chmod +x pwnb.sh

# Run the enumeration
./pwnb.sh
```

### Results
All enumeration output is copied in real-time to the `privilege_escalation_report.txt` file in the same directory. You can use it later to document your audit.

---

## Output

<img width="602" alt="Screenshot 2025-04-01 at 12 05 22 PM" src="https://github.com/user-attachments/assets/1a4de8d2-2ab5-402f-86b3-0c2b038970a1" />

https://github.com/user-attachments/assets/f46f6f8f-481e-4219-931e-41a45db7735e


## Contributing

Contributions are welcome! If you have ideas for new checks, improvements, or bug fixes, feel free to:

- Open an issue
- Submit a pull request
- Share the tool with fellow hackers

## 📄 License
This project is licensed under the MIT License.

## Author
Developed by [Alexander B]
Founder of Cyber Sector | Red Teamer | Fullstack Builder | Security Disruptor

☕ Support the project: buymeacoffee.com/alexboteroh

## ⚠️ Disclaimer
This tool is designed **strictly** for educational purposes, authorized security auditing, and legal CND/CNE exercises. The author assumes no responsibility for misuse or damage caused to third-party systems without explicit authorization.

## 🔓 PwnBraker
**PwnBraker** — Escalate intelligently. Break systems ethically. Become the root of power.
