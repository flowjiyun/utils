apt install -y gcc curl git vim openssh-server net-tools pkg-config libssl-dev iproute2
apt install -y sqlite3 libsqlite3-dev
apt install -y net-tools iputils-ping bridge-utils
apt install -y clang
apt install -y gnutls-bin libgnutls28-dev
apt install -y mingw-w64 cmake nasm
apt install -y sshpass


apt install -y tshark
sudo chmod +x /usr/bin/dumpcap
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

# nmap
apt install -y nmap

# snort2
apt install -y snort
systemctl stop snort
systemctl disable snort
systemctl mask snort
systemctl is-enabled snort

# python3
apt install -y python3
apt install -y python3-pip
pip install -y idstools

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.bashrc 
rustup target add x86_64-pc-windows-gnu
rustup target add x86_64-unknown-linux-gnu

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc 
nvm install 18

# cti_ipc
cargo install wasm-pack

curl --proto '=https' --tlsv1.2 -LsSf https://github.com/diesel-rs/diesel/releases/download/v2.2.1/diesel_cli-installer.sh | sh
source ~/.bashrc 
# arm인경우, diesel 수동설치
cargo install diesel_cli --no-default-features --features "sqlite"

# ntp
sudo apt install -y ntp

# pcap
apt install -y libpcap-dev

# virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
sudo apt update
apt install virtualbox-7.0
wget https://download.virtualbox.org/virtualbox/7.0.18/Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack
vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.18.vbox-extpack

# docker
apt-get update
apt install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
