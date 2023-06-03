#!/bin/bash
#set -e

# This script will be executed on the first startup of each new container with the "my-resources" feature enabled.
# Arbitrary code can be added in this file, in order to customize Exegol (dependency installation, configuration file copy, etc).
# It is strongly advised **not** to overwrite the configuration files provided by exegol (e.g. /root/.zshrc, /opt/.exegol_aliases, ...), official updates will not be applied otherwise.

# Exegol also features a set of supported customization a user can make.
# The /opt/supported_setups.md file lists the supported configurations that can be made easily.
LAUNCH_DIRECTORY="$PWD"

# remove history
echo -n > ~/.zsh_history

# pentest environment variables source
FILE=/workspace/.env
touch $FILE
echo "CLIENT=''" >> $FILE
echo "DOMAIN=''" >> $FILE
echo "FQDN=''" >> $FILE
echo "DC=''" >> $FILE
echo "DC2=''" >> $FILE
echo "DC3=''" >> $FILE
echo "USER=''" >> $FILE
echo "PASSWORD=''" >> $FILE
echo "USER_ADM=''" >> $FILE
echo "PASSWORD_ADM=''" >> $FILE

# custom arsenal
python3 -m pipx uninstall arsenal
rm /root/.local/bin/arsenal
git clone --depth 1 https://github.com/JulienBedel/arsenal /tools/arsenal && cd /tools/arsenal
python3 -m pip install -r requirements.txt
python3 setup.py install
cd $LAUNCH_DIRECTORY

# PrintNightmare scan and exploit
python3 -m pipx install poetry
git -C /opt/tools clone https://github.com/eversinc33/ItWasAllADream
cd /opt/tools/ItWasAllADream
/root/.local/bin/poetry install
cd $LAUNCH_DIRECTORY
git -C /opt/tools clone https://github.com/cube0x0/CVE-2021-1675

# noPac scan and exploit
git -C /opt/tools clone https://github.com/Ridter/noPac

# switch to crackmapexec audit mode
sed -i 's/audit_mode =/audit_mode = */g' ~/.cme/cme.conf

# build internal pentest tree
mkdir /workspace/attacks
mkdir /workspace/attacks/adcs
mkdir /workspace/attacks/crack
mkdir /workspace/attacks/cve
mkdir /workspace/attacks/acl
mkdir /workspace/attacks/mitm
mkdir /workspace/attacks/postex
mkdir /workspace/attacks/relay
mkdir /workspace/attacks/snowball
mkdir /workspace/attacks/spray
mkdir /workspace/attacks/webdav
mkdir /workspace/enumeration
mkdir /workspace/enumeration/bloodhound
mkdir /workspace/enumeration/nmap
mkdir /workspace/enumeration/pingcastle
mkdir /workspaces/enumeration/nessus
mkdir /workspace/loot
mkdir /workspace/loot/files
mkdir /workspace/loot/credz
mkdir /workspace/notes
touch /workspace/notes/brief.md
touch /workspace/notes/todo.md
touch /workspace/notes/comptes.md
touch /workspace/notes/partages.md
touch /workspace/notes/questions.md
touch /workspace/notes/postex.md
mkdir /workspace/screenshot
mkdir /workspace/targets

