## Setup server ngrok để  ssh vào colab
Tạo instance trên google cloud
Public ra các port 7000, 8000, 8001, 10000-10050
- Tạo ra firewall rule với target tags là *open-ngrok-port*
- Thêm tag *open-ngrok-port* vào instance 

Allow các port này trong instance bằng ufw
sudo ufw allow 7000
sudo ufw allow 8000
sudo ufw allow 8001
sudo uwf allow 4443
sudo ufw allow 10000:10050
