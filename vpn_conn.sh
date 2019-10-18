#!/usr/bin/expect

set username "eg:wangch@username"
set password "eg:123456"
set timeout 20

#spawn ssh root@127.0.0.1
spawn sudo openvpn /etc/openvpn/my.ovpn
expect {
	"*wangch 的sudo密码*" {
		send "$password\r\n"
		exp_continue
	}
	"*yes/no*" {
		send "yes\r\n"
		exp_continue
	}
	"Enter Auth Username:" {
		send "$username\r"
		exp_continue
	}
	"Enter Auth Password:" {
		send "$password\r"
	}
}
interact
