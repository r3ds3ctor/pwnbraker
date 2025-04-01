#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Progress Bar Function
progress_bar() {
    local duration=$1
    local increment=$((duration / 100))
    echo -ne "["
    for i in $(seq 1 100); do
        sleep $increment
        echo -ne "="
    done
    echo -ne "]\n"
}

# Header
echo -e "${YELLOW}Starting Linux Privilege Escalation Check...${NC}"
echo -e "${GREEN}Analyzing system...${NC}"
progress_bar 2 &

output_file="privilege_escalation_report.txt"
> "$output_file"

# 1. Kernel version
echo -e "\n${YELLOW}[+] Kernel Version:${NC}" | tee -a "$output_file"
uname -a | tee -a "$output_file"

# 2. SUID and SGID files
echo -e "\n${YELLOW}[+] Searching for SUID and SGID binaries...${NC}" | tee -a "$output_file"
find / -perm -4000 -o -perm -2000 -type f 2>/dev/null | tee -a "$output_file"

# 3. Checking sudo permissions
echo -e "\n${YELLOW}[+] Checking sudo permissions...${NC}" | tee -a "$output_file"
sudo -l | tee -a "$output_file"

# 4. Checking for writable files and directories
echo -e "\n${YELLOW}[+] Searching for writable files and directories...${NC}" | tee -a "$output_file"
find / -writable -type d 2>/dev/null | tee -a "$output_file"

# 5. Checking user and group information
echo -e "\n${YELLOW}[+] User and Group Information:${NC}" | tee -a "$output_file"
id | tee -a "$output_file"
groups | tee -a "$output_file"

# 6. Searching for world-writable files owned by root
echo -e "\n${YELLOW}[+] Searching for world-writable files owned by root...${NC}" | tee -a "$output_file"
find / -xdev -user root -perm -o+w -type f 2>/dev/null | tee -a "$output_file"

# 7. Checking for possible GTFOBins escalation
echo -e "\n${YELLOW}[+] Checking for GTFOBins escalation vectors...${NC}" | tee -a "$output_file"
for bin in $(find / -type f -perm -4000 -exec basename {} \; 2>/dev/null); do
    echo -e "${GREEN}[*] Checking $bin...${NC}" | tee -a "$output_file"
    curl -s "https://gtfobins.github.io/gtfobins/$bin/" | grep -i "sudo" | tee -a "$output_file"
done

# 8. Checking for capabilities
echo -e "\n${YELLOW}[+] Checking for capabilities...${NC}" | tee -a "$output_file"
getcap -r / 2>/dev/null | tee -a "$output_file"

# 9. Checking PATH for writable directories
echo -e "\n${YELLOW}[+] Checking PATH for writable directories...${NC}" | tee -a "$output_file"
IFS=':' read -ra PATH_DIRS <<< "$PATH"
for dir in "${PATH_DIRS[@]}"; do
    if [ -w "$dir" ]; then
        echo -e "${RED}[*] Writable PATH directory: $dir${NC}" | tee -a "$output_file"
    fi
done

# 10. Checking for open ports
echo -e "\n${YELLOW}[+] Checking for open ports...${NC}" | tee -a "$output_file"
netstat -tuln | tee -a "$output_file"

# 11. Checking for Docker and LXC containers
echo -e "\n${YELLOW}[+] Checking for Docker and LXC containers...${NC}" | tee -a "$output_file"
if [ -f /.dockerenv ]; then
    echo -e "${RED}[*] Running inside a Docker container.${NC}" | tee -a "$output_file"
fi
if [ "$(cat /proc/1/cgroup 2>/dev/null | grep -i lxc)" != "" ]; then
    echo -e "${RED}[*] Running inside an LXC container.${NC}" | tee -a "$output_file"
fi

# 12. Searching for SSH private keys
echo -e "\n${YELLOW}[+] Searching for SSH private keys...${NC}" | tee -a "$output_file"
find / -name "id_rsa" -o -name "id_dsa" -type f 2>/dev/null | tee -a "$output_file"

# 13. Checking for readable /etc/shadow
if [ -r /etc/shadow ]; then
    echo -e "\n${RED}[*] /etc/shadow is readable!${NC}" | tee -a "$output_file"
fi

# 14. Checking for kernel exploits (using searchsploit)
echo -e "\n${YELLOW}[+] Searching for kernel exploits (searchsploit)...${NC}" | tee -a "$output_file"
if command -v searchsploit &> /dev/null; then
    searchsploit linux kernel | tee -a "$output_file"
else
    echo -e "${RED}[!] searchsploit not installed.${NC}" | tee -a "$output_file"
fi

# Summary
echo -e "\n${GREEN}[*] Privilege escalation check completed.${NC}"
echo -e "${YELLOW}[+] Results saved to: $output_file${NC}"

# Prompt for privilege escalation attempt
echo -e "\n${YELLOW}Do you want to attempt privilege escalation? (y/n)${NC}"
read -r response

if [[ "$response" == "y" ]]; then
    echo -e "${RED}[*] Attempting escalation...${NC}"
    
    # Attempt via sudo
    if sudo -n id &>/dev/null; then
        echo -e "${GREEN}[+] Escalation via sudo succeeded!${NC}"
        sudo /bin/bash
    else
        echo -e "${RED}[-] Escalation failed.${NC}"
    fi
else
    echo -e "${GREEN}[*] Exiting.${NC}"
fi
