qoraMonitor
===========
> qoraMonitor is built for qora node. qoraMonitor can show whether your node is running well.

## Getting start

### First install qora

If you are first install qora wallet. Plea as these step:

```
sudo su -
apt-get update
apt-get upgrade

apt-get install openjdk-7-jdk screen unzip

mkdir qora
cd qora
wget http://coinia.net/qora/Qora.last.zip -O qora.zip
unzip -o qora.zip
cd Qora

echo -e '{\n"knownpeers":["146.185.141.232","162.243.170.76","42.159.153.145","88.198.69.99","85.21.237.35","193.242.149.63","113.250.226.131"],\n"minconnections": 10,\n"maxconnections": 100\n}'>settings.json


echo -e "java -Xmx512m -Djava.library.path=libs/native -jar Qora.jar -disablegui">run.sh
chmod 777 run.sh

screen -d -m -S qora ./run.sh
```

If you just to upgrade qora, you should fallow these step:

```
cd qora

kill -9 `ps aux | grep 'jar Qora.jar \-' | awk '/root/ {print $2}'

wget http://coinia.net/qora/Qora.last.zip -O qora.zip
unzip -o qora.zip
cd Qora
rm -R data
rm -R wallet

echo -e '{\n"knownpeers":["146.185.141.232","162.243.170.76","42.159.153.145","88.198.69.99","85.21.237.35","193.242.149.63","113.250.226.131"],\n"minconnections": 10,\n"maxconnections": 100\n}'>settings.json

echo -e "java -Xmx512m -Djava.library.path=libs/native -jar Qora.jar -disablegui">run.sh

chmod 777 run.sh
screen -d -m -S qora ./run.sh
```

### Then, intall  qoraMonitor

#### First, install node.js

```
sudo apt-get update
sudo apt-get install nodejs

sudo apt-get install nodejs-legacy

sudo apt-get update

sudo apt-get install nodejs
```

Then, you can text this to check:

```
node -v
```
#### Install npm (Node package manager)

```
sudo apt-get update
sudo apt-get install npm
```
Check version of npm:

```
npm -v
```

#### Install qoraMonitor

```
cd 
cd qora
sudo apt-get install git

git clone https://github.com/soliury/qoraMonitor.git
cd qoraMonitor
cp  settings.example.js  settings.js

npm install
sudo npm install forever -g
cd bin
forever start www
```

Then you brower the url : `your ip `+ `:3000`

You will see the login page. 

The default user is `qoranode`, password is `qoranode`.

If you want to change the login user and the password, you should edit the settings.js.



```
(function() {
    module.exports = {
        loginUserName: "qoranode",          //login user name
        loginPwd: "qoranode",               //login password
        cookie: "asdfaqweroqwejr098e0sdkjgoasduaoisd"           //just text something here.
    };

}).call(this);
```

This is the monitor page: 

<img width="" height="" class="amd-center" src="http://lingyong-me.qiniudn.com/E777DE10-AFD2-4313-92C1-877B435A257A.png 2014-9-16 16:56-px1366" alt="screenshot" />

