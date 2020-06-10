set -e
IP_SERVER="$1"
SSH_KEY="$2"
APP_RUN="$3"
echo "IP_SERVER: $IP_SERVER, APP_RUN: $APP_RUN"
mkdir -p ~/.ssh
sudo apt-get install ssh
mv sshd_config /etc/ssh/sshd_config
echo $SSH_KEY >> ~/.ssh/authorized_keys
service ssh restart

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc && echo "export LD_LIBRARY_PATH" >> /root/.bashrc

echo "${IP_SERVER}    colab.tunnel" | sudo tee /etc/hosts
wget "http://${IP_SERVER}:7000"
mv index.html ngrok
chmod +x ngrok
echo "./ngrok -config=ngrok-config start ${APP_RUN} &" > run_ngrok.sh
cat run_ngrok.sh
chmod +x run_ngrok.sh
#./ngrok -config=ngrok-config start ${APP_RUN} &
#curl -s http://localhost:4040/http/in | grep window.data