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


# Setup ngrok server và sử dụng colab như một remote server


## Table of Contents
* [About the Project](#about-the-project)
* [Getting Started]()
    * [Prerequisites]()
* [Setup server]()
    * [Create an vm-instace on Google cloud engine]()
    * [Install ngrok docker on the vm-instance]()
* [Setup on Colab notebook]()
* [Results]()
* [Contact]()
* [Acknowledgements]()


## About the Project

Trong qúa trình làm việc sử dụng Google colab, mình gặp một vấn đề rất khó chịu là Colab sử dụng Jupyter Notebook để làm 
việc. Một số vấn đề có thể kể đến là:

- **Code xấu:** Code cả project trong chỉ một notebook của colab thì nó xấu vch, chưa kể là cái gợi ý function của nó cũng
chậm làm giảm năng suất code, không phê được như Pycharm. Có thể khắc phục bằng cách là code ở local 
và push lên github sau đó clone về colab. Cách này code đẹp tí nhưng bắt tay vào làm thì hơi cực chứ không dễ.
  
- **Khó debug:** Bạn nào đã từng sử dụng Pycharm ở các máy local thì sẽ thấy n kỳ diệu thế nào.

- **Sử dụng terminal không linh hoạt:** Sử dụng terminal trong colab sida sau cái code xấu vừa chậm vừa khó nhìn. 
Mỗi lần muốn chạy một câu lệnh mới là xóa cell hiện tại đi hoặc phải tạo một cell mới
 
- **Phải lưu kết quả vào google drive:** Tốn dung lượng drive. Phức tạp khi code và sử dụng.
- **Khó theo dõi được Tensorboard**
- ......

Trong project này mình sẽ chia sẻ một cách làm việc hiệu quả với Google colab cho các bạn newbie. Một số chức năng được 
cung cấp:
- ssh vào colab và thao tác trên terminal với độ trễ thấp.
- Code và debug với Pycharm ở local và tự động đồng bộ code lên colab server.
- Tự động download các kết quả(checkpoint, log,...) về local thay vì phải lưu vào 
drive.I
- Theo dõi tensorboard từ local browser, hoặc bất kỳ thiết bị nào truy cập được internet.

## Getting started
### Prerequisites

Để thực hiện project này thì sẽ cần:
- Một server với IP tĩnh. Để demo mình sẽ sử dụng một máy ảo trên google cloud(Các bạn ra 
ngân hàng đăng ký một thẻ debit, dùng thẻ này để đăng ký sẽ được $300 free trong vòng một năm).
- Kỹ năng sử dụng linux terminal cơ bản.
- Máy tính để code. Laptop mình sử dụng có tuổi đời 7 năm, ram 4Gb.


## Setup server
### Tạo máy ảo trên google cloud
Mình tạo ra một máy ảo *g1-small 1vCPU, 1.7 GB memory* ở Hongkong với giá khoảng  ~598 VNĐ/H

![](images/vminstance.png)

Cấu hình để thêm ssh public key vào và mở các port  7000, 8000, 8001, 4443, 10000 đến 10050 để sử dụng. Chi tiết cho bạn 
nào chưa làm được mình sẽ viết riêng sau.


