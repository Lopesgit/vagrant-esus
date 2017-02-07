#!/bin/bash

ESUS_INSTALLER_FILE=Instalador-eSUS-AB-PEC-2.1.08-Treinamento-Linux_20122016.zip
ESUS_INSTALLER_PATH=/home/ubuntu/esus_installer
ESUS_INSTALLER_URL=http://189.28.128.100/dab/docs/portaldab/aplicativos/$ESUS_INSTALLER_FILE

echo '# add repository of openjdk-7-jdk'
add-apt-repository ppa:openjdk-r/ppa -y

echo '# running apt-get with update, upgrade and dist-upgrade'
apt-get --yes update
apt-get --yes upgrade
apt-get --yes dist-upgrade


echo '# installing openjdk-7-jdk'
apt-get install -y openjdk-7-jdk
update-alternatives --config java
update-alternatives --config javac

echo '# installing unzip'
apt-get install -y unzip

echo '# installing htop'
apt-get install -y htop

echo '# running apt-get with autoremove'
apt-get --yes autoremove

echo '# set environment variable JAVA_HOME'
touch /etc/java.conf
echo "JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /etc/java.conf

echo "# download e-SUSAB installer"
curl -O $ESUS_INSTALLER_URL
# mv $ESUS_INSTALLER /home/ubuntu/shared/

echo "# extract e-SUSAB installer"
mkdir $ESUS_INSTALLER_PATH
unzip $ESUS_INSTALLER_FILE -d $ESUS_INSTALLER_PATH
rm $ESUS_INSTALLER_FILE

echo "# set locale like pt_BR.UTF-8"
sed -ie 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

echo "# execute installer"
sh $ESUS_INSTALLER_PATH/instalador_linux.sh

touch /home/ubuntu/esus.sh
echo '#!/bin/sh' >> /home/ubuntu/esus.sh
echo 'sudo /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-lsb.sh $1' >> /home/ubuntu/esus.sh
echo '#!/bin/sh' >> /home/ubuntu/esus.sh
chown ubuntu /home/ubuntu/esus.sh
chgrp ubuntu /home/ubuntu/esus.sh
chmod a+x /home/ubuntu/esus.sh
ln -s /home/ubuntu/esus.sh /usr/bin/esus

touch /home/ubuntu/esus_bkp.sh
echo '#!/bin/sh' >> /home/ubuntu/esus_bkp.sh
echo 'sudo esus stop' >> /home/ubuntu/esus_bkp.sh
echo 'echo "realizando backup do banco de dados do e-SUSAB..."' >> /home/ubuntu/esus_bkp.sh
echo 'sudo PGPASSWORD="esus" /opt/e-SUS/jboss-as-7.2.0.Final/PostgreSQL/9.3/bin/pg_dump -h localhost -p 5433 -U postgres -d esus -F c -f /home/ubuntu/esus_backups/$1' >> /home/ubuntu/esus_bkp.sh
echo 'echo "backup finalizado."' >> /home/ubuntu/esus_bkp.sh
echo 'sudo esus start' >> /home/ubuntu/esus_bkp.sh
chown ubuntu /home/ubuntu/esus_bkp.sh
chgrp ubuntu /home/ubuntu/esus_bkp.sh
chmod a+x /home/ubuntu/esus_bkp.sh
ln -s /home/ubuntu/esus_bkp.sh /usr/bin/esus_bkp

touch /home/ubuntu/esus_rest.sh
echo '#!/bin/sh' >> /home/ubuntu/esus_rest.sh
echo 'sudo esus stop' >> /home/ubuntu/esus_rest.sh
echo 'echo "restaurando banco de dados do e-SUSAB..."' >> /home/ubuntu/esus_rest.sh
echo 'sudo PGPASSWORD="esus" /opt/e-SUS/jboss-as-7.2.0.Final/PostgreSQL/9.3/bin/pg_restore -h localhost -p 5433 -U postgres -c -F c -d esus /home/ubuntu/esus_backups/$1' >> /home/ubuntu/esus_rest.sh
echo 'echo "restauração finalizada."' >> /home/ubuntu/esus_rest.sh
echo 'sudo esus start' >> /home/ubuntu/esus_rest.sh
chown ubuntu /home/ubuntu/esus_rest.sh
chgrp ubuntu /home/ubuntu/esus_rest.sh
chmod a+x /home/ubuntu/esus_rest.sh
ln -s /home/ubuntu/esus_rest.sh /usr/bin/esus_rest

esus_bkp bdblank.dump