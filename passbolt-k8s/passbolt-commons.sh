#!/bin/bash


echo "# Create GPG config file gpg-server-key.conf with the following content."

cat > gpg-server-key.conf <<EOF
%echo Generating a basic OpenPGP key
 Key-Type: RSA
 Key-Length: 4096
 Subkey-Type: RSA
 Subkey-Length: 4096
 Name-Email: passbolt@bradoquy.com.br
 Name-Real: Passbolt Admin
 Expire-Date: 0
 %echo done
EOF

echo "# Create GPG keys."
gpg --gen-key --batch gpg-server-key.conf

echo "# List GPG keys."
gpg --list-secret-keys --keyid-format LONG 

echo "# Export keys."
KEY_ID=<put your key here>
gpg --armor --export $KEY_ID > serverkey.asc
gpg --armor --export-secret-keys $KEY_ID > serverkey_private.asc