#!/bin/bash


echo "Script para deploy do passbolt e banco de dados mysql"
echo "Uso: escolha um namespace e um repo para instalar ex **bitnami/mysql**"


echo "Setando Namespace"
read -rp "namespace que será usado: ($NAMESPACE): " escolha;
if [ "$escolha" != "" ] ; then
export NS="$escolha";
fi

echo "Setando MySql repo"
read -rp "coloque o repo Mysql: " repoMysql;
if [ "$repoMysql" != "" ] ; then
export MYSQL_CHART="$repoMysql";
fi


helm upgrade --wait --install --namespace $NS -f ./default/mysql/values.yaml mysql-passbolt $MYSQL_CHART

while [ $(kubectl get pod -n $NS | grep mysql-passbolt | awk '{if(NR==1){print $2}}') '!=' '1/1' ]; do
  echo "Esperando o mysql ficar running"
  sleep 1
done

helm upgrade --wait --install --namespace $NS -f ./default/passbolt/values.yaml passbolt ./passbolt-chart
