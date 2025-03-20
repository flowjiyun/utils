#!/bin/bash
set -e

cd cm_dep
# Extract the tarball
tar -xzf offline_deps.tar.gz
tar -xzf nvm.tar.gz
tar -xzf rust.tar.gz
tar -xzf bashrc_backup.tar.gz

# Install the dependencies
sudo dpkg -i offline_deps/*.deb

# Copy .cargo / .rustup / .nvm to home directory
cp -r .cargo "$HOME/"
cp -r .rustup "$HOME/"
cp -r .nvm "$HOME/"

# Set profile
echo '. $HOME/.cargo/env' >> "$HOME/.profile"

# Set bashrc
cat << 'EOF' >> "$HOME/.bashrc"
. $HOME/.cargo/env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

# Install vbox extension pack
vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.24.vbox-extpack