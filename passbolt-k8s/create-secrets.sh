#!/bin/bash

export NAMESPACE=${NAMESPACE:="defaul"}

read -rp "namespace que será usado: ($NAMESPACE): " escolha;
if [ "$escolha" != "" ] ; then
export NAMESPACE="$escolha";
fi

echo " o namespace é $NAMESPACE "

echo "# Criando a credential secret no K8S - Mysql"
kubectl create secret generic mysql-passbolt-creds -n $NAMESPACE --from-literal=mysql-root-password=root123 --from-literal=mysql-password=passbolt123

echo "# Criando a SSL secret no K8S - Mysql"
openssl rsa -in ./default/mysql/certs/mysql.key -out ./default/mysql/certs/mysql.key.rsa

kubectl create secret generic mysql-passbolt-ssl -n $NAMESPACE --from-file=ca.pem=./default/mysql/certs/ca.pem --from-file=server-cert.pem=./default/mysql/certs/mysql.crt --from-file=server-key.pem=./default/mysql/certs/mysql.key.rsa

echo "# Criando a SSL secret no K8S - Passbolt"

kubectl create secret generic ssl-passbolt -n $NAMESPACE --from-file=certificate.crt=./default/passbolt/certs/certificate.crt --from-file=certificate.key=./default/passbolt/certs/certificate.key --from-file=mysql-ca.pem=./default/mysql/certs/ca.pem --from-file=mysql-cert.pem=./default/mysql/certs/mysql.crt --from-file=mysql-key.pem=./default/mysql/certs/mysql.key.rsa

echo "# Criando a GPG secret no K8S - Passbolt"
kubectl create secret generic gpg-passbolt -n $NAMESPACE --from-file=serverkey.asc=./default/passbolt/gpg/serverkey.asc --from-file=serverkey_private.asc=./default/passbolt/gpg/serverkey_private.asc






