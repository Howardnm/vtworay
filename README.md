# vtworay
docker v2ray 一键安装脚本

# 复制到ssh运行
```bash
yum -y install wget
yum -y install curl
```
# 一、安装bbr（可选）
bbr，建议在centos 7运行，看文字输入数字，步骤：1、安装bbrplus，2、优化配置，3、重启后启动bbrplus
```bash
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```
# 二、一键docker脚本
```bash
wget  https://raw.githubusercontent.com/Howardnm/vtworay/main/v2rayinstall.sh && chmod +x v2rayinstall.sh && ./v2rayinstall.sh
```
# 三、订阅后，修改ip即可使用
###### $$
<img src="https://github.com/Howardnm/vtworay/raw/main/images/ss.jpg" width="10%">

###### $$r
<img src="https://github.com/Howardnm/vtworay/raw/main/images/ssr.jpg" width="15%">

###### vmmess
<img src="https://github.com/Howardnm/vtworay/raw/main/images/vmesstcp.jpg" width="20%">   <img src="https://github.com/Howardnm/vtworay/raw/main/images/vmessmkcp.jpg" width="20%">

# 四、一键docker 应用软件脚本（可选）
```bash
wget  https://raw.githubusercontent.com/Howardnm/vtworay/main/dockerotherinstall.sh && chmod +x dockerotherinstall.sh && ./dockerotherinstall.sh
```
