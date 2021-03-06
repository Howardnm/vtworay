#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
mkdir /etc/v2ray
	echo "检查Docker......"
	docker -v
    if [ $? -eq  0 ]; then
        echo "检查到Docker已安装!"
    else
clear
    	echo "安装docker环境..."
        curl -sSL https://get.daocloud.io/docker | sh
        systemctl start docker
        systemctl enable docker
        echo -e "安装docker环境...安装完成!"
	sleep 1
    fi
clear
    echo -e "  一键安装v2ray脚本 howard v3.3
————————————————————————————————
 ${Green_font_prefix}1.${Font_color_suffix} 安装 v2ray ssr ss
 ${Green_font_prefix}2.${Font_color_suffix} 卸载 v2ray ssr ss
 ${Green_font_prefix}3.${Font_color_suffix} 显示 v2ray ssr ss二维码
 ${Green_font_prefix}4.${Font_color_suffix} 下载客户端
 ${Green_font_prefix}5.${Font_color_suffix} 退出
————————————————————————————————"
read -t 30 -p "输入对应数字【1-5】 :" howard
if [ "${howard}" = "1" ]; then
	read -t 30 -p "要安装v2ray ？ y或n :" vtworay
	if [ "${vtworay}" = "y" ]; then
		rm -f /etc/v2ray/*
		wget -P /etc/v2ray/ https://raw.githubusercontent.com/Howardnm/vtworay/main/config_mkcp_detour.json 
		wget -P /etc/v2ray/ https://raw.githubusercontent.com/Howardnm/vtworay/main/config_tcp.json 
		wget -P /etc/v2ray/ https://raw.githubusercontent.com/Howardnm/vtworay/main/config_mkcp.json
		#wget -P /etc/v2ray/ https://raw.githubusercontent.com/Howardnm/vtworay/main/config_tcp_http.json
		awk '/port/' /etc/v2ray/config_tcp.json>/etc/v2ray/config_tcp_port.json
		awk '{print $2}' /etc/v2ray/config_tcp_port.json>/etc/v2ray/config_tcp_port2.json
		tcpport=$(cat /etc/v2ray/config_tcp_port2.json)
		awk '/port/' /etc/v2ray/config_mkcp.json>/etc/v2ray/config_mkcp_port.json
		awk '{print $2}' /etc/v2ray/config_mkcp_port.json>/etc/v2ray/config_mkcp_port2.json
		mkcpport=$(cat /etc/v2ray/config_mkcp_port2.json)
		#awk '/port/' /etc/v2ray/config_tcp_http.json>/etc/v2ray/config_tcp_http_port.json
		#awk '{print $2}' /etc/v2ray/config_tcp_http_port.json>/etc/v2ray/config_tcp_http_port2.json
		#tcphttpport=$(cat /etc/v2ray/config_tcp_http_port2.json)
		rm /etc/v2ray/config_tcp_port.json /etc/v2ray/config_tcp_port2.json /etc/v2ray/config_mkcp_port.json /etc/v2ray/config_mkcp_port2.json #/etc/v2ray/config_tcp_http_port.json /etc/v2ray/config_tcp_http_port2.json
		docker run -d --name v2ray_mkcp --restart=always -v /etc/v2ray:/etc/v2ray -p ${mkcpport}:${mkcpport} -p ${mkcpport}:${mkcpport}/udp v2fly/v2fly-core  v2ray -config=/etc/v2ray/config_mkcp.json
		docker run -d --name v2ray_tcp --restart=always -v /etc/v2ray:/etc/v2ray -p ${tcpport}:${tcpport} -p ${tcpport}:${tcpport}/udp v2fly/v2fly-core  v2ray -config=/etc/v2ray/config_tcp.json
		#docker run -d --name v2ray_tcp_http --restart=always -v /etc/v2ray:/etc/v2ray -p ${tcphttpport}:${tcphttpport} -p ${tcphttpport}:${tcphttpport}/udp v2fly/v2fly-core  v2ray -config=/etc/v2ray/config_tcp_http.json
clear
	fi
	echo "————————————————————————————————"
	read -t 30 -p "要安装ss和ssr ？ y或n :" ssrss
	if [ "${ssrss}" = "y" ]; then
		docker run -d -p 54019:8388 -p 54019:8388/udp --name shadowsocks-libev --restart=always -e SERVER_PORT="8388" -e PASSWORD="hxc123" -e METHOD="aes-128-gcm" -e DNS_ADDRS="8.8.8.8,223.5.5.5,8.8.4.4,114.114.114.114" -e TIMEOUT="3000" shadowsocks/shadowsocks-libev
		docker run -d -p 54009:8388 -p 54009:8388/udp --name shadowsocksR-libev --restart=always -e SERVER_PORT="8388" -e PASSWORD="hxc123" -e METHOD="aes-128-cfb" -e DNS_ADDRS="8.8.8.8,223.5.5.5,8.8.4.4,114.114.114.114" -e TIMEOUT="3000" shadowsocks/shadowsocks-libev
clear
	fi
	wanip=`curl http://pv.sohu.com/cityjson 2>> /dev/null | awk -F '"' '{print $4}'`
	if [ "${vtworay}" = "y" ]; then
	echo -e "————————————mkcp————————————————
vmess://ew0KICAidiI6ICIyIiwNCiAgInBzIjogInYycmF5LWttY3AiLA0KICAiYWRkIjogIjAuMC4wLjAiLA0KICAicG9ydCI6ICI1MjAwMSIsDQogICJpZCI6ICI5YWM5YTBiMy1lODBiLTQ2NmItODEzYS03MzhjNmNmZDQ2Y2QiLA0KICAiYWlkIjogIjIwIiwNCiAgIm5ldCI6ICJrY3AiLA0KICAidHlwZSI6ICJub25lIiwNCiAgImhvc3QiOiAiIiwNCiAgInBhdGgiOiAiIiwNCiAgInRscyI6ICIiLA0KICAic25pIjogIiINCn0=
————————————tcp—————————————————
vmess://ew0KICAidiI6ICIyIiwNCiAgInBzIjogInYycmF5LXRjcCIsDQogICJhZGQiOiAiMC4wLjAuMCIsDQogICJwb3J0IjogIjUxMDAxIiwNCiAgImlkIjogIjlhYzlhMGIzLWU4MGItNDY2Yi04MTNhLTczOGM2Y2ZkNDZjZCIsDQogICJhaWQiOiAiMjAiLA0KICAibmV0IjogInRjcCIsDQogICJ0eXBlIjogIm5vbmUiLA0KICAiaG9zdCI6ICIiLA0KICAicGF0aCI6ICIiLA0KICAidGxzIjogIiIsDQogICJzbmkiOiAiIg0KfQ=="
	fi
	if [ "${ssrss}" = "y" ]; then
	echo -e "————————ss——ssr—————————————————
ss://YWVzLTEyOC1nY206aHhjMTIzQDAuMC4wLjA6NTQwMTk#ss
ssr://MC4wLjAuMDo1NDAwOTpvcmlnaW46YWVzLTEyOC1jZmI6cGxhaW46YUhoak1USXovP3JlbWFya3M9YzNOeSZwcm90b3BhcmFtPSZvYmZzcGFyYW09"
	fi
echo "————————————————————————————————"
echo -n "订阅后，客户端将ip改为" ; echo $wanip
echo -e "即可使用，或者到网页扫码订阅：https://github.com/Howardnm/docker-vtworay
或者重新运行脚本，按“3”显示二维码
————————————————————————————————"
elif [ "${howard}" = "2" ]; then
	read -t 30 -p "要卸载v2ray？ y或n :" vtworaydel
	if [ "${vtworaydel}" = "y" ]; then
		docker stop v2ray_mkcp v2ray_tcp #v2ray_tcp_http
		docker rm v2ray_mkcp v2ray_tcp #v2ray_tcp_http
		rm -f /etc/v2ray/*
		echo "已卸载v2ray"
	elif [ "${vtworaydel}" = "n" ]; then
		echo "---"
	fi
	echo "————————————————————————————————"
	read -t 30 -p "要卸载ssr和ss？ y或n :" ssrssdel
		if [ "${ssrssdel}" = "y" ]; then
		docker stop shadowsocks-libev shadowsocksR-libev
		docker rm shadowsocks-libev shadowsocksR-libev
		echo "已卸载ssr和ss"
	elif [ "${ssrssdel}" = "n" ]; then
		echo "---"
	fi
clear
echo -e "
————————————————————————————————
脚本已结束，再见！！
————————————————————————————————
docker正在运行的容器：
————————————————————————————————"
docker ps
echo -e "————————————————————————————————"
elif [ "${howard}" = "3" ]; then
	qrencode --help
	if [ $? -eq  0 ]; then
	echo "检查到qrencode已安装!"
	else
	yum -y install qrencode
	fi
clear
	    echo -e "—————————选择二维码—————————————
${Green_font_prefix}1.${Font_color_suffix} v2ray mkcp
${Green_font_prefix}2.${Font_color_suffix} v2ray tcp
${Green_font_prefix}3.${Font_color_suffix} ss
${Green_font_prefix}4.${Font_color_suffix} ssr
${Green_font_prefix}5.${Font_color_suffix} 退出
————————————————————————————————"
	read -t 30 -p "输入对应数字【1-5】 :" QRcode
	if [ "${QRcode}" = "1" ]; then
	echo -n 'vmess://ew0KICAidiI6ICIyIiwNCiAgInBzIjogInYycmF5LWttY3AiLA0KICAiYWRkIjogIjAuMC4wLjAiLA0KICAicG9ydCI6ICI1MjAwMSIsDQogICJpZCI6ICI5YWM5YTBiMy1lODBiLTQ2NmItODEzYS03MzhjNmNmZDQ2Y2QiLA0KICAiYWlkIjogIjIwIiwNCiAgIm5ldCI6ICJrY3AiLA0KICAidHlwZSI6ICJub25lIiwNCiAgImhvc3QiOiAiIiwNCiAgInBhdGgiOiAiIiwNCiAgInRscyI6ICIiLA0KICAic25pIjogIiINCn0=' | qrencode -o - -t UTF8
	elif [ "${QRcode}" = "2" ]; then
	echo -n 'vmess://ew0KICAidiI6ICIyIiwNCiAgInBzIjogInYycmF5LXRjcCIsDQogICJhZGQiOiAiMC4wLjAuMCIsDQogICJwb3J0IjogIjUxMDAxIiwNCiAgImlkIjogIjlhYzlhMGIzLWU4MGItNDY2Yi04MTNhLTczOGM2Y2ZkNDZjZCIsDQogICJhaWQiOiAiMjAiLA0KICAibmV0IjogInRjcCIsDQogICJ0eXBlIjogIm5vbmUiLA0KICAiaG9zdCI6ICIiLA0KICAicGF0aCI6ICIiLA0KICAidGxzIjogIiIsDQogICJzbmkiOiAiIg0KfQ==' | qrencode -o - -t UTF8
	elif [ "${QRcode}" = "3" ]; then
	echo -n 'ss://YWVzLTEyOC1nY206aHhjMTIzQDAuMC4wLjA6NTQwMTk#ss' | qrencode -o - -t UTF8
	elif [ "${QRcode}" = "4" ]; then
	echo -n 'ssr://MC4wLjAuMDo1NDAwOTpvcmlnaW46YWVzLTEyOC1jZmI6cGxhaW46YUhoak1USXovP3JlbWFya3M9YzNOeSZwcm90b3BhcmFtPSZvYmZzcGFyYW09' | qrencode -o - -t UTF8
	fi
wanip=`curl http://pv.sohu.com/cityjson 2>> /dev/null | awk -F '"' '{print $4}'`
echo -n "扫码后，将ip改为" ; echo $wanip
echo "————————————脚本已结束————————————————"
elif [ "${howard}" = "4" ]; then
clear
	    echo -e "下载方法：
————————————————————————————————
${Green_font_prefix}1.${Font_color_suffix} 一键搭建网盘，在浏览器下载（建议）
${Green_font_prefix}2.${Font_color_suffix} 直接下载（请用Xshell、FinalShell登录ssh才能运行该选项）
${Green_font_prefix}3.${Font_color_suffix} 退出
————————————————————————————————
直接在github下载客户端：https://github.com/Howardnm/vtworay/releases/tag/v2rayN
————————————————————————————————"
	read -t 30 -p "输入对应数字【1-3】 :" downloadss
	if [ "${downloadss}" = "1" ]; then
	docker stop filebrowser
	docker rm filebrowser
	rm -rf /root/filebrowser
	docker run -d -p 8081:80 -p 8081:80/udp --name filebrowser  -v /root/filebrowser/sites/root:/srv -v /root/filebrowserconfig.json:/etc/config.json -v /root/filebrowser/database.db:/etc/database.db filebrowser/filebrowser
	wanip=`curl http://pv.sohu.com/cityjson 2>> /dev/null | awk -F '"' '{print $4}'`
	wget -P /root/filebrowser/sites/root/ https://github.com/Howardnm/vtworay/releases/download/v2rayN/Xshell-7.0.0054p.exe
	wget -P /root/filebrowser/sites/root/ https://github.com/Howardnm/vtworay/releases/download/v2rayN/v2rayN-Core-4.12.zip
	wget -P /root/filebrowser/sites/root/ https://github.com/Howardnm/vtworay/releases/download/v2rayN/Shadowsocks-4.4.0.185.zip
	wget -P /root/filebrowser/sites/root/ https://github.com/Howardnm/vtworay/releases/download/v2rayN/ShadowsocksR-win-4.9.2.zip
	clear
	echo "————————————————————————————————"
	echo -n "请在浏览器打开 http://" ; echo -n $wanip ; echo ":8081"
	echo " "
	echo "账号：admin 密码：admin"
	echo "————————————————————————————————"
	echo "在网页进行下载客户端"
	echo "————————————————————————————————"
	elif [ "${downloadss}" = "2" ]; then
clear
	    echo -e "一键下载客户端
————————————————————————————————
${Green_font_prefix}1.${Font_color_suffix} 下载 v2rayN windows客户端
${Green_font_prefix}2.${Font_color_suffix} 下载 ssr 客户端 windows客户端
${Green_font_prefix}3.${Font_color_suffix} 下载 ss 客户端 windows客户端
${Green_font_prefix}4.${Font_color_suffix} 退出
————————————————————————————————"
	read -t 30 -p "输入对应数字【1-4】 :" downloadsclient
			if [ "${downloadsclient}" = "1" ]; then
				rz -h
				if [ $? -eq  0 ]; then
clear
				echo "准备中。。。"
				else
				yum -y install lrzsz
clear
				fi
			rm /etc/v2ray/v2rayN-Core.zip
			wget -P /etc/v2ray/ https://github.com/Howardnm/vtworay/releases/download/v2rayN/v2rayN-Core-4.12.zip
			sz /etc/v2ray/v2rayN-Core-4.12.zip
			echo "结束"
			elif [ "${downloadsclient}" = "2" ]; then
				rz -h
				if [ $? -eq  0 ]; then
clear
				echo "准备中。。。"
				else
				yum -y install lrzsz
clear
				fi
			rm /etc/v2ray/Shadowsocks.zip
			wget -P /etc/v2ray/ https://github.com/Howardnm/vtworay/releases/download/v2rayN/Shadowsocks-4.4.0.185.zip
			sz /etc/v2ray/Shadowsocks-4.4.0.185.zip
			echo "结束"
			elif [ "${downloadsclient}" = "3" ]; then
				rz -h
				if [ $? -eq  0 ]; then
clear
				echo "准备中。。。"
				else
				yum -y install lrzsz
clear
				fi
			rm /etc/v2ray/ShadowsocksR-win.zip
			wget -P /etc/v2ray/ https://github.com/Howardnm/vtworay/releases/download/v2rayN/ShadowsocksR-win-4.9.2.zip
			sz /etc/v2ray/ShadowsocksR-win-4.9.2.zip
			echo "结束"
			fi
	else
clear
	echo "脚本已结束，再见！！"
	fi
else
clear
	    echo -e "
————————————————————————————————
脚本已结束，再见！！
————————————————————————————————
docker正在运行的容器：
————————————————————————————————"
docker ps
echo -e "————————————————————————————————"
fi

rm -- "$0"
