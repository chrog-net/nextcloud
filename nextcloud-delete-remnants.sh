#/bin/bash
ls /var/www/html/nextcloud/data/ | grep -Ev "ncadmin|nextcloud.log|index.html|appdata_|files_external" > /tmp/nextcloud-allusers
for i in `cat /tmp/nextcloud-allusers`; do sudo -u www-data php /var/www/html/nextcloud/occ ldap:check-user "$i"; done
sudo -u www-data php /var/www/html/nextcloud/occ ldap:show-remnants
sudo -u www-data php /var/www/html/nextcloud/occ ldap:show-remnants  | awk '{print $2}' | sed "2d;/^\s*$/d" > /tmp/nextcloud-delusers
for i in `cat /tmp/nextcloud-delusers`; do sudo -u www-data php /var/www/html/nextcloud/occ user:delete "$i"; done
