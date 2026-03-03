# ⚡ PwnBraker (pwnb.sh)

<img width="839" alt="Screenshot 2025-04-01 at 1 29 16 PM" src="https://github.com/user-attachments/assets/4dd33276-00b5-4b15-8c3e-4678826d5f54" />

**Practical Linux Privilege Escalation & Enumeration Script**

A powerful Linux privilege escalation reconnaissance tool built for red teamers, penetration testers, and security researchers. It analyzes a Linux system to identify weaknesses, misconfigurations, and known escalation vectors. All in one automated script.

> "A veces la victoria está en la simplicidad."

PwnBraker (`pwnb.sh`) es un script de Bash enfocado en la **enumeración rápida, visual y pragmática** para escalamiento de privilegios en sistemas Linux y Unix. A diferencia de las herramientas gigantes o auto-exploiters sobre-complicados, PwnBraker sigue una filosofía clara: **Mostrarte todo lo que necesitas ver, y luego intentar el vector más directo.**

## 🎯 Filosofía de Diseño
En el pentesting real y las operaciones Red Team, los scripts automatizados que buscan condiciones "perfectas" a menudo fallan silenciosamente. `pwnb.sh` está diseñado bajo el principio de que **la mejor herramienta es la que no falla y no asume**. Presenta la información en pantalla, la guarda en un reporte, y en lugar de ejecutar una docena de exploits inestables, intenta inteligentemente la vía de escalamiento más común (`sudo bash`). Si falla, te deja con un reporte completo para explotación manual.

---

## 🚀 Módulos de Enumeración (14 Vectores)

PwnBraker inspecciona el sistema secuencialmente en busca de configuraciones erróneas y vectores locales:

1. **Kernel Version**: Muestra la versión (`uname -a`) para cruzar con exploits públicos.
2. **SUID & SGID Binaries**: Lista binarios con el bit SetUID/SetGID activado.
3. **Sudo Privileges**: Obtiene permisos habilitados mediante `sudo -l`.
4. **Writable Directories**: Busca carpetas donde el usuario tenga permisos de escritura a nivel raíz (`/`).
5. **User & Group Info**: Extrae tu contexto actual de UID/GID (`id`, `groups`).
6. **World-Writable Root Files**: Encuentra archivos críticos que root posee pero otros pueden editar.
7. **GTFOBins Live Check**: (Online) Cruza dinámicamente binarios SUID con la base de datos de GTFOBins en internet para detectar vectores conocidos de sudo.
8. **Capabilities**: Lista capabilities críticas asignadas a binarios (`getcap`).
9. **Writable PATHs**: Verifica si algún directorio en tu `$PATH` es modificable (Path Hijacking).
10. **Open Ports**: Revisa puertos locales expuestos mediante `netstat`.
11. **Container Detection**: Identifica si estás operando dentro de Docker o LXC.
12. **SSH Keys**: Busca llaves privadas (`id_rsa`, `id_dsa`) expuestas en el sistema.
13. **Shadow File Check**: Alerta roja si `/etc/shadow` es legible por tu usuario.
14. **Local Exploit Search**: (Si `searchsploit` está instalado), busca exploits aplicables al kernel actual.

---

## ⚡ La Explotación (El "Hail Mary")

Tras finalizar el escaneo visual y guardar un reporte limpio en `privilege_escalation_report.txt`, el script se detiene y pregunta:

`Do you want to attempt privilege escalation? (y/n)`

Si respondes `y`, PwnBraker intentará un vector puro y directo: ejecutar `/bin/bash` bajo `sudo` sin contraseña (`sudo -n id`). Si el administrador dejó configuraciones abiertas globales (como `NOPASSWD: ALL` o permisos holgados), este intento simple **te devolverá una shell interactiva como root instantáneamente**.

---

## 💻 Quick Start

```bash
# Descargar el script
curl -O https://raw.githubusercontent.com/r3ds3ctor/pwnbraker/main/pwnb.sh

# Dar permisos de ejecución
chmod +x pwnb.sh

# Ejecutar la enumeración
./pwnb.sh
```

### Resultados
Toda la salida de la enumeración se copia en tiempo real al archivo `privilege_escalation_report.txt` en el mismo directorio. Puedes usarlo posteriormente para documentar tu auditoría.

---

## Output

<img width="602" alt="Screenshot 2025-04-01 at 12 05 22 PM" src="https://github.com/user-attachments/assets/1a4de8d2-2ab5-402f-86b3-0c2b038970a1" />

https://github.com/user-attachments/assets/f46f6f8f-481e-4219-931e-41a45db7735e


## Contributting

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

## ⚠️ Aviso Legal
Esta herramienta está diseñada **únicamente** para fines educativos, auditorías de seguridad autorizadas, y ejercicios CND/CNE legales. El autor no se hace responsable del uso indebido ni del daño que pueda causar en sistemas de terceros sin autorización explícita.

## 🔓 PwnBraker
**PwnBraker** — Escalate intelligently. Break systems ethically. Become the root of power.
