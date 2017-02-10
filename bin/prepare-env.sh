#!/bin/bash

# Allow to attach to container
sleep 15

# Check if configuration file exists in data container
if [ -f /data/lib/LocalSite.cfg ] ; then
  echo "External LocalSite.cfg exists, remove template"
  rm /var/www/twiki/lib/LocalSite.cfg
else
  echo "Missing LocalSite.cfg, preparing config based on template"
  CRYPT_PW=$(perl -e 'my $pass = $ENV{ADMIN_PW}; my @saltchars = ( "a".."z", "A".."Z", "0".."9", ".", "/" ); my $salt = $saltchars[int(rand($#saltchars+1))] . $saltchars[int(rand($#saltchars+1)) ]; print crypt($pass, $salt);' )
  URL_HOST=$( echo ${URL_HOST} | sed -e 's:/$::' )
  mv /var/www/twiki/lib/LocalSite.cfg /data/lib/LocalSite.cfg
  sed -i "s|%PW%|${CRYPT_PW}|;s|%URL_HOST%|${URL_HOST}|;s|%SCRIPT_PATH%|${SCRIPT_PATH}|;s|%PUP_PATH%|${PUP_PATH}|;s|%ADMIN_NAME%|${ADMIN_NAME}|;s|%ADMIN_EMAIL%|${ADMIN_EMAIL}|" /data/lib/LocalSite.cfg
fi
echo "linking LocalSite.cfg"
ln -s /data/lib/LocalSite.cfg /var/www/twiki/lib/LocalSite.cfg

echo "preparing data-share ..."
# Check if we hava some data already
if [ -f /data/data/mime.types ] ; then
  echo "removing stock data ..."
  rm -rf /var/www/twiki/data
  rm -rf /var/www/twiki/pub
else
  echo "moving stock data ..."
  mv /var/www/twiki/data /var/www/twiki/pub /data/
fi
echo "linking data directories ..."
ln -s /data/data /var/www/twiki/data
ln -s /data/pub  /var/www/twiki/pub
echo "system is ready, have fun!"


# Check if ssl cert and key exists in data container
if [ -f /data/ssl-certs/wiki-key.pem ] ; then
  echo "External wiki-key.pem exists"
  rm -f /data/ssl-certs/wiki-key.pem.missing
else
  echo "Missing wiki-key.pem, create empty one"
  echo "Add wiki-key.pem key in this folder" > /data/ssl-certs/wiki-key.pem.missing
fi
if [ -f /data/ssl-certs/wiki-fullchain.pem ] ; then
  echo "External wiki-fullchain.pem exists"
  rm -f /data/ssl-certs/wiki-fullchain.pem.missing
else
  echo "Missing wiki-fullchain.pem, create empty one"
  echo "Add wiki-fullchain.pem key in this folder" > /data/ssl-certs/wiki-fullchain.pem.missing
fi
