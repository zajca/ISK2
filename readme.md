Návod na isntalaci:

Závislosti:
NodeJS 10+
Python2

Stažení aktuálních souborů:
git clone https://github.com/zajca/ISK2.git ./

instalace závislostí (krok také nainstaluje bower závislosti)
npm install

instalace globálních závislostí:
npm install -g gulp
npm install -g coffeescript

spuštění development buildu:
gulp dev

spuštění HapiJS serveru:
ENV=dev coffee index.coffee

server je pak dostupný na adrese localhost:3000

spuštění CLSI  serveru:
git clone git@github.com:sharelatex/clsi-sharelatex.git ./clsi
cd ./clsi
npm install
npm install -g grunt
grunt install
grunt run

clsi je pak dostupný na adrese localhost:3013