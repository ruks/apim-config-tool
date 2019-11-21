#same host
km_host=localhost
km_offset=0
tm_host=localhost
tm_offset=1
gw_host=localhost
gw_offset=2
st_host=localhost
st_offset=3
pb_host=localhost
pb_offset=4

#multi nodes
km_host=km.wso2.com
tm_host=tm.wso2.com
gw_host=gw.wso2.com
st_host=store.wso2.com
pb_host=publisher.wso2.com

db_host=localhost
db_port=3306
db_user=root
db_pass=pass
am_db=amdb
shared_db=sharedDB

km_conf="[server]
server_role = \"api-key-manager\"
hostname = \"$km_host\"
node_ip = \"127.0.0.1\"
offset=$km_offset

[user_store]
type = \"database\"

[super_admin]
username = \"admin\"
password = \"admin\"
create_admin_account = true

[database.apim_db]
type = \"mysql\"
hostname = \"$db_host\"
name = \"$am_db\"
port = $db_port
username = \"$db_user\"
password = \"$db_pass\"

[database.shared_db]
type = \"mysql\"
hostname = \"$db_host\"
name = \"$shared_db\"
port = $db_port
username = \"$db_user\"
password = \"$db_pass\"

[keystore.tls]
file_name =  \"wso2carbon.jks\"
type =  \"JKS\"
password =  \"wso2carbon\"
alias =  \"apimsetup\"
key_password =  \"wso2carbon\"

[truststore]
file_name = \"client-truststore.jks\"
type = \"JKS\"
password = \"wso2carbon\"

[[apim.gateway.environment]]
name = \"Production and Sandbox\"
type = \"hybrid\"
display_in_api_console= true
description = \"This is a hybrid gateway that handles both production and sandbox token traffic.\"
service_url = \"https://$gw_host:$(( 9443 + km_offset ))/services/\"
username= \"\${admin.username}\"
password= \"\${admin.password}\"

[[apim.throttling.url_group]]
traffic_manager_urls=[\"tcp://$tm_host:$(( 9611 + tm_offset ))\"]
traffic_manager_auth_urls=[\"ssl://$tm_host:$(( 9711 + tm_offset ))\"]"

tm_conf="[server]
hostname = \"$tm_host\"
node_ip = \"127.0.0.1\"
server_role = \"traffic-manager\"
offset=$tm_offset

[user_store]
type = \"database\"

[super_admin]
username = \"admin\"
password = \"admin\"
create_admin_account = true

[database.shared_db]
type = \"h2\"
url = \"jdbc:h2:./repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE\"
username = \"wso2carbon\"
password = \"wso2carbon\"

[keystore.tls]
file_name =  \"wso2carbon.jks\"
type =  \"JKS\"
password =  \"wso2carbon\"
alias =  \"apimsetup\"
key_password =  \"wso2carbon\"

[truststore]
file_name = \"client-truststore.jks\"
type = \"JKS\"
password = \"wso2carbon\""

pub_conf="[server]
hostname = \"$pb_host\"
node_ip = \"127.0.0.1\"
server_role = \"api-publisher\"
offset=$pb_offset

[user_store]
type = \"database\"

[super_admin]
username = \"admin\"
password = \"admin\"
create_admin_account = true

[database.apim_db]
type = \"mysql\"
hostname = \"$db_host\"
name = \"$am_db\"
port = $db_port
username = \"$db_user\"
password = \"$db_pass\"

[database.shared_db]
type = \"mysql\"
hostname = \"$db_host\"
name = \"$shared_db\"
port = $db_port
username = \"$db_user\"
password = \"$db_pass\"

[keystore.tls]
file_name =  \"wso2carbon.jks\"
type =  \"JKS\"
password =  \"wso2carbon\"
alias =  \"apimsetup\"
key_password =  \"wso2carbon\"

[truststore]
file_name = \"client-truststore.jks\"
type = \"JKS\"
password = \"wso2carbon\"

[[apim.gateway.environment]]
name = \"Production and Sandbox\"
type = \"hybrid\"
display_in_api_console = true
description = \"This is a hybrid gateway that handles both production and sandbox token traffic.\"
service_url = \"https://$gw_host:$(( 9443 + gw_offset ))/services/\"
http_endpoint = \"http://$gw_host:$(( 8280 + gw_offset ))\"
https_endpoint = \"https://$gw_host:$(( 8243 + gw_offset ))\"
username = \"\${admin.username}\"
password = \"\${admin.password}\"

[apim.throttling]
service_url = \"https://$tm_host:$(( 9443 + gw_offset ))/services/\"
throttle_decision_endpoints = [\"tcp://$tm_host:$(( 5672 + tm_offset ))\"]

[[apim.throttling.url_group]]
traffic_manager_urls =[\"tcp://$tm_host:$(( 9611 + tm_offset ))\"]
traffic_manager_auth_urls =[\"ssl://$tm_host:$(( 9711 + tm_offset ))\"]

[apim.devportal]
url = \"https://$st_host:$(( 9443 + st_offset ))/devportal\""

devp_conf="[server]
hostname = \"$st_host\"
node_ip = \"127.0.0.1\"
server_role=\"api-store\"
offset=$st_offset

[user_store]
type = \"database\"

[super_admin]
username = \"admin\"
password = \"admin\"
create_admin_account = true

[database.apim_db]
type = \"mysql\"
hostname = \"$db_host\"
name = \"$am_db\"
port = $db_port
username = \"$db_user\"
password = \"$db_pass\"

[database.shared_db]
type = \"mysql\"
hostname = \"$db_host\"
name = \"$shared_db\"
port = $db_port
username = \"$db_user\"
password = \"$db_pass\"

[keystore.tls]
file_name =  \"wso2carbon.jks\"
type =  \"JKS\"
password =  \"wso2carbon\"
alias =  \"apimsetup\"
key_password =  \"wso2carbon\"

[truststore]
file_name = \"client-truststore.jks\"
type = \"JKS\"
password = \"wso2carbon\"

[[apim.gateway.environment]]
name = \"Production and Sandbox\"
type = \"hybrid\"
display_in_api_console = true
description = \"This is a hybrid gateway that handles both production and sandbox token traffic.\"
service_url = \"https://$gw_host:$(( 9443 + gw_offset ))/services/\"
http_endpoint = \"http://$gw_host:$(( 8280 + gw_offset ))\"
https_endpoint = \"https://$gw_host:$(( 8243 + gw_offset ))\"
username = \"\${admin.username}\"
password = \"\${admin.password}\"
show_as_token_endpoint_url = true

[apim.key_manager]
service_url = \"https://$km_host:$(( 9443 + km_offset ))/services/\"
username= \"\$ref{super_admin.username}\"
password= \"\$ref{super_admin.password}\"

[apim.oauth_config]
revoke_endpoint = \"https://$gw_host:$(( 8243 + gw_offset ))/revoke\""

gw_conf="[server]
hostname = \"$gw_host\"
node_ip = \"127.0.0.1\"
server_role = \"gateway-worker\"
offset=$gw_offset

[user_store]
type = \"database\"

[super_admin]
username = \"admin\"
password = \"admin\"
create_admin_account = true

[database.shared_db]
type = \"mysql\"
hostname = \"$db_host\"
name = \"$shared_db\"
port = $db_port
username = \"$db_user\"
password = \"$db_pass\"

[keystore.tls]
file_name =  \"wso2carbon.jks\"
type =  \"JKS\"
password =  \"wso2carbon\"
alias =  \"apimsetup\"
key_password =  \"wso2carbon\"

[truststore]
file_name = \"client-truststore.jks\"
type = \"JKS\"
password = \"wso2carbon\"

[apim.key_manager]
service_url = \"https://$km_host:$(( 9443 + km_offset ))/services/\"

[apim.throttling]
throttle_decision_endpoints = [\"tcp://$tm_host:$(( 5672 + tm_offset ))\"]

[[apim.throttling.url_group]]
traffic_manager_urls =[\"tcp://$tm_host:$(( 9611 + tm_offset ))\"]
traffic_manager_auth_urls =[\"ssl://$tm_host:$(( 9711 + tm_offset ))\"]

[apim.cors]
allow_origins = \"*\"
allow_methods = [\"GET\",\"PUT\",\"POST\",\"DELETE\",\"PATCH\",\"OPTIONS\"]
allow_headers = [\"authorization\",\"Access-Control-Allow-Origin\",\"Content-Type\",\"SOAPAction\"]
allow_credentials = false"

rm -rf target
mkdir target
cd target
echo "Extracting API Manager"
unzip -qq ../wso2am-3.0.0.zip
curl https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.48/mysql-connector-java-5.1.48.jar -o mysql-connector-java-5.1.48.jar
{ 
keytool -genkey -alias apimsetup -keyalg RSA -keysize 2048 -keystore wso2carbon.jks -dname "CN=*.wso2.com, OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass wso2carbon -keypass wso2carbon
keytool -export -alias apimsetup -keystore wso2carbon.jks -file wso2carbon.pem -storepass wso2carbon
keytool -import -alias apimsetup -file wso2carbon.pem -keystore client-truststore.jks -storepass wso2carbon -noprompt
} &> /dev/null
echo "Certificated generated"

echo "Configuring Key Manager"
rm -rf keymanager
mkdir keymanager && cd keymanager
cp -r ../wso2am-3.0.0 ./
{ 
	./wso2am-3.0.0/bin/profileSetup.sh -Dprofile=api-key-manager 
} &> /dev/null
cp ../mysql-connector-java-5.1.48.jar wso2am-3.0.0/repository/components/lib
echo "$km_conf" > "wso2am-3.0.0/repository/conf/deployment.toml"
cd ../

echo "Configuring Traffic Manager"
rm -rf trafficManager
mkdir trafficManager && cd trafficManager
cp -r ../wso2am-3.0.0 ./
{ 
	./wso2am-3.0.0/bin/profileSetup.sh -Dprofile=traffic-manager
} &> /dev/null
cp ../mysql-connector-java-5.1.48.jar wso2am-3.0.0/repository/components/lib
echo "$tm_conf" > "wso2am-3.0.0/repository/conf/deployment.toml"
cd ../

echo "Configuring Publisher"
rm -rf publisher
mkdir publisher && cd publisher
cp -r ../wso2am-3.0.0 ./
{ 
	./wso2am-3.0.0/bin/profileSetup.sh -Dprofile=api-publisher
} &> /dev/null
cp ../mysql-connector-java-5.1.48.jar wso2am-3.0.0/repository/components/lib
echo "$pub_conf" > "wso2am-3.0.0/repository/conf/deployment.toml"
cd ../

echo "Configuring Dev portal"
rm -rf devportal
mkdir devportal && cd devportal
cp -r ../wso2am-3.0.0 ./
{ 
	./wso2am-3.0.0/bin/profileSetup.sh -Dprofile=api-devportal
} &> /dev/null
cp ../mysql-connector-java-5.1.48.jar wso2am-3.0.0/repository/components/lib
echo "$devp_conf" > "wso2am-3.0.0/repository/conf/deployment.toml"
cd ../

echo "Configuring Gateway"
rm -rf gateway
mkdir gateway && cd gateway
cp -r ../wso2am-3.0.0 ./
{ 
	./wso2am-3.0.0/bin/profileSetup.sh -Dprofile=gateway-worker
} &> /dev/null
cp ../mysql-connector-java-5.1.48.jar wso2am-3.0.0/repository/components/lib
echo "$gw_conf" > "wso2am-3.0.0/repository/conf/deployment.toml"
cd ../

rm -rf ../wso2am-3.0.0






