#!/bin/bash
clear
curl -sSL https://raw.githubusercontent.com/molla202/Scripts/main/molla202.sh | bash
install_binary() {
exec > /dev/null 2>&1
cd $HOME
rm -rf ojo
git clone https://github.com/ojo-network/ojo.git
cd ojo
git checkout v0.1.2
make install
exec > /dev/tty 2>&1
}
BinaryName="ojod"
NodeName="ojo"
binaryversion="v0.1.2"
ChainID="ojo-devnet"
CustomPort="12"
echo -e "\e[0;34m$NodeName Kurulumu Başlatılıyor\033[0m"
sleep 3
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER 
echo -e "\033[035mMoniker isminiz\033[034m $MONIKER \033[035molarak kaydedildi"
echo -e '\e[0m'
echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
echo "export BinaryName=$BinaryName" >> $HOME/.bash_profile
echo "export ChainID=$ChainID" >> $HOME/.bash_profile
echo "export CustomPort=$CustomPort" >> $HOME/.bash_profile
source $HOME/.bash_profile
sleep 2
echo -e ''
curl -sSL https://raw.githubusercontent.com/molla202/Scripts/main/remove-cosmos-node.sh | bash
echo -e "\e[0;34mSunucu Hazırlanıyor\033[0m"
curl -sSL https://raw.githubusercontent.com/molla202/Scripts/main/preparing-server.sh | bash
echo -e "\e[0;34mGo Kuruluyor\033[0m"
curl -sSL https://raw.githubusercontent.com/molla202/Scripts/main/install-go.sh | bash
echo -e "\e[0;33m$(go version) Kuruldu\033[0m"
echo -e "\e[0;34m$BinaryName Kuruluyor\033[0m"
install_binary
echo -e "\e[0;33m$BinaryName $($BinaryName version) Kuruldu\033[0m"
sleep 1
echo -e "\e[0;34mYapılandırma Dosyası Ayarları Yapılıyor\033[0m"
curl -sSL https://raw.githubusercontent.com/molla202/Scripts/main/init.sh | bash
wget -O $HOME/.ojo/config/addrbook.json https://raw.githubusercontent.com/molla202/Ojo-Network/main/addrbook.json
wget -O $HOME/.ojo/config/genesis.json https://raw.githubusercontent.com/molla202/Ojo-Network/main/genesis.json
curl -sSL https://raw.githubusercontent.com/molla202/Scripts/main/config.sh | bash
curl -sSL https://raw.githubusercontent.com/molla202/Scripts/main/systemctl.sh | bash
curl -sSL https://raw.githubusercontent.com/molla202/Scripts/main/startnode.sh | bash
sleep 1
echo -e "\e[0;34mNode Başlatıldı\033[0m"
sleep 1
echo -e ""
echo -e "\e[0;32mLogları Görüntülemek İçin:\033[0;33m           sudo journalctl -u $BinaryName -fo cat\e[0m"
echo -e ""
echo -e ""
sleep 1
echo -e "\e[0;34mKurulum Tamamlandı\e[0m\u2600"

