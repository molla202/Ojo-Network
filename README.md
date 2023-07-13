<img width="1024" alt="header@2x" src="https://github.com/molla202/Ojo-Network/assets/91562185/979e2833-c9c2-4e36-90ba-0a1ac7ad2bd0">


<h1 align="center"> Ojo Network </h1>

 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Ojo Network Website](https://ojo.network/)<br>
 * [Blockchain Explorer](https://ojo.explorers.guru/)<br>
 * [Discord](https://discord.gg/tygWr7JM2w)<br>
 * [Twitter](https://twitter.com/ojo_network)<br>


## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4 |
| RAM	| 8 GB |
| Storage	| 250 GB SSD |

## Oto kurulum
```
curl -sSL -o ojo.sh https://raw.githubusercontent.com/molla202/Ojo-Network/main/ojo.sh && chmod +x ojo.sh && bash ./ojo.sh
```
## Update & Kütüphane 
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```
## Go kurulumu
```
cd $HOME
! [ -x "$(command -v go)" ] && {
VER="1.19.3"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
}
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```
## Varyasyonları atayalım
Not: cüzdan adı ve node adı değiştiriniz.
```
echo "export WALLET="cüzdan-adı"" >> $HOME/.bash_profile
echo "export MONIKER="node-adı"" >> $HOME/.bash_profile
echo "export OJO_CHAIN_ID="ojo-devnet"" >> $HOME/.bash_profile
echo "export OJO_PORT="12"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
## binary dosyaları indirelim
```
cd $HOME
rm -rf ojo
git clone https://github.com/ojo-network/ojo.git
cd ojo
git checkout v0.1.2
make install
```
## init işlemi
```
ojod config node tcp://localhost:${OJO_PORT}657
ojod config keyring-backend os
ojod config chain-id ojo-devnet
ojod init "molla202" --chain-id ojo-devnet
```
## genesis ve addrbook indirelim
```
wget -O $HOME/.ojo/config/addrbook.json https://raw.githubusercontent.com/molla202/Ojo-Network/main/addrbook.json
wget -O $HOME/.ojo/config/genesis.json https://raw.githubusercontent.com/molla202/Ojo-Network/main/genesis.json
```
## seeds ve peers ekleyelim
```
SEEDS="7186f24ace7f4f2606f56f750c2684d387dc39ac@ojo-testnet-seed.itrocket.net:12656"
PEERS="d2489830a5e91ec214edfc54756512e4f89f2609@ojo-testnet-peer.itrocket.net:12656,8fbfa810cb666ddef1c9f4405e933ef49138f35a@65.108.199.120:54656,e54b02d103f1fcf5189a86abe542670979d2029d@65.109.85.170:58656,1626881c604cba71cbbc8cddd0fb5a5cb2adf2f0@87.106.114.73:33656,f6d6e625759814e157457a5889961e02dba26ba6@65.109.92.240:37096,8f414276a2cb7a97d37a3e126c186972e1968039@65.108.4.233:56656,0d4dc8d9e80df99fdf7fbb0e44fbe55e0f8dde28@65.108.205.47:14756,ba99038e9de54698765e47316c1d778aeb390a46@95.217.57.232:26656,7831b3b3d625757c749d17569c6730f6589d35fe@65.109.48.181:29656,20d9bb13b09c054c30f1b48fbd276aa255af5a34@65.108.238.147:37656,3c6384ae2a167912a5ace2f5f8e38afc559715f0@75.119.156.88:26656,5acc5ccc09dc10f5bc12c4ba4468a03c3df9d1ea@65.108.8.28:61356,83a0043b2a2bfff38c3725c70f4c0305c760dfef@213.239.207.175:47656,2c40b0aedc41b7c1b20c7c243dd5edd698428c41@138.201.85.176:26696,6e0b45d32722df1a612d723e289e59ede65a9dd1@65.109.61.113:24214"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.ojo/config/config.toml
```
## port yapılandırması app.toml
```
sed -i.bak -e "s%:1317%:${OJO_PORT}317%g;
s%:8080%:${OJO_PORT}080%g;
s%:9090%:${OJO_PORT}090%g;
s%:9091%:${OJO_PORT}091%g;
s%:8545%:${OJO_PORT}545%g;
s%:8546%:${OJO_PORT}546%g;
s%:6065%:${OJO_PORT}065%g" $HOME/.ojo/config/app.toml
```
## port yapılandırması config.toml
```
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${OJO_PORT}658\"%; 
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://0.0.0.0:${OJO_PORT}657\"%; 
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${OJO_PORT}060\"%;
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${OJO_PORT}656\"%;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${OJO_PORT}656\"%;
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${OJO_PORT}660\"%" $HOME/.ojo/config/config.toml
```
## puring
```
sed -i -e "s/^pruning *=.*/pruning = \"nothing\"/" $HOME/.ojo/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.ojo/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.ojo/config/app.toml
```
## gas ayarı prometheus, index kapayalım
```
sed -i 's/minimum-gas-prices =.*/minimum-gas-prices = "0.0uojo"/g' $HOME/.ojo/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.ojo/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.ojo/config/config.toml
```
## servis dosyası oluşturalım
```
sudo tee /etc/systemd/system/ojod.service > /dev/null <<EOF
[Unit]
Description=Ojo node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.ojo
ExecStart=$(which ojod) start --home $HOME/.ojo
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
## servisleeri başlatalım 
```
sudo systemctl daemon-reload
sudo systemctl enable ojod
sudo systemctl restart ojod
```
## Logları kontrol edelim
```
sudo journalctl -u ojod -fo cat
```
