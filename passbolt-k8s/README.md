# Install Passbolt no kubernetes

* Instalando MySQL DB.
* Installs [Passbolt](https://www.passbolt.com/) password manager.

#### Criando secrets
############################################# MYSQL #############################################
## Criando a credential secret no K8S                                                           #
#                                                                                               #
# $ kubectl create secret generic mysql-passbolt-creds -n [NAMESPACE] \                         #
#             --from-literal=mysql-root-password=root123 \                                      #
#             --from-literal=mysql-password=passbolt123                                         #
#                                                                                               #
## Criando a SSL secret no K8S                                                                  #
#                                                                                               #
#                                                                                               #
# $ openssl rsa -in ./default/mysql/certs/mysql.key -out ./default/mysql/certs/mysql.key.rsa    #
#                                                                                               #
# $ kubectl create secret generic mysql-passbolt-ssl -n [NAMESPACE] \                           #
#             --from-file=ca.pem=./default/mysql/certs/ca.pem \                                 #
#             --from-file=server-cert.pem=./default/mysql/certs/mysql.crt \                     #
#             --from-file=server-key.pem=./default/mysql/certs/mysql.key.rsa                    #
#                                                                                               #
########################################### PASSBOLT ############################################
## Criando a SSL secret no K8S                                                                     #
#                                                                                               #
# $ kubectl create secret generic ssl-passbolt -n [NAMESPACE] \                            #
#             --from-file=certificate.crt=./default/passbolt/certs/certificate.crt \            #
#             --from-file=certificate.key=./default/passbolt/certs/certificate.key \            #
#             --from-file=mysql-ca.pem=./default/mysql/certs/ca.pem \                           #
#             --from-file=mysql-cert.pem=./default/mysql/certs/mysql.crt \                      #
#             --from-file=mysql-key.pem=./default/mysql/certs/mysql.key.rsa                     #
#                                                                                               #
## Criando a GPG secret no K8S                                                                     #
#                                                                                               #
# $ kubectl create secret generic gpg-passbolt -n [NAMESPACE] \                            #
#             --from-file=serverkey.asc=./default/passbolt/gpg/serverkey.asc \                  #
#             --from-file=serverkey_private.asc=./default/passbolt/gpg/serverkey_private.asc    #
#                                                                                               #
#################################################################################################
############################# Manter tudo em segurança #############################
#################################################################################################

#### Executar Script
```console
$ ./deploy-to-k8.sh
```

#### Depois que o passbolt estiver em execução, execute ssh no pod do passbolt e execute o seguinte comando para criar um usuário administrador.
```
su -s /bin/bash -c "./bin/cake passbolt register_user -r admin -u passboltadmin@bradoquy.com.br -f Tiago -l Oliveira" www-data
```

### Help
```
su -s /bin/bash -c "./bin/cake passbolt --help"
```

kubectl create secret generic mysql-passbolt-creds -n [NAMESPACE] \                         
            --from-literal=mysql-root-password=root123 \                                      
            --from-literal=mysql-password=passbolt123

