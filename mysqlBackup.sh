#!/bin/bash

# ����������Ϣ���Լ��޸�
mysql_user="root" #MySQL�����û�
mysql_password="p@ssw0rd" #MySQL�����û�������
mysql_host="192.168.20.190"
mysql_port="3306"
mysql_charset="utf8mb4" #MySQL����
backup_db_arr=("flarum" "flarum_wcl") #Ҫ���ݵ����ݿ����ƣ�����ÿո�ֿ����� ��("db1" "db2" "db3")
backup_location="/home/ryen/bak" #�������ݴ��λ�ã�ĩβ�벻Ҫ��"/",������Ա���Ĭ�ϣ�������Զ������ļ���
expire_backup_delete="OFF" #�Ƿ������ڱ���ɾ�� ONΪ���� OFFΪ�ر�
expire_days=3 #����ʱ������ Ĭ��Ϊ���죬����ֻ����expire_backup_delete����ʱ��Ч

readonly mysql_user
readonly mysql_password
readonly mysql_host
readonly mysql_port
readonly mysql_charset
readonly backup_db_arr
readonly backup_location
readonly expire_backup_delete
 
# ���п�ʼ���²���Ҫ�޸�
backup_time=`date +%Y%m%d%H%M` #���屸����ϸʱ��
backup_Ymd=`date +%Y/%m/%d` #���屸��Ŀ¼�е�������ʱ��
backup_3ago=`date -d '3 days ago' +%Y/%m/%d` #3��֮ǰ������
backup_dir=$backup_location/$backup_Ymd #�����ļ���ȫ·��
welcome_msg="Welcome to use MySQL backup tools!" #��ӭ��
 
# �ж�MYSQL�Ƿ�������mysqlû�������򱸷��˳�
# mysql_ps=`ps -ef |grep mysql |wc -l`
# mysql_listen=`netstat -an |grep LISTEN |grep $mysql_port|wc -l`
# if [ [$mysql_ps == 0] -o [$mysql_listen == 0] ]; then
# echo "ERROR:MySQL is not running! backup stop!"
# exit
# else
# echo $welcome_msg
# fi
 
# ���ӵ�mysql���ݿ⣬�޷������򱸷��˳�
mysql -h$mysql_host -P$mysql_port -u$mysql_user -p$mysql_password <<end
use mysql;
select host,user from user where user='root' and host='localhost';
exit
end
 
flag=`echo $?`
if [ $flag != "0" ]; then
echo "ERROR:Can't connect mysql server! backup stop!"
exit
else
echo "MySQL connect ok! Please wait......"
# �ж���û�ж��屸�ݵ����ݿ⣬���������ʼ���ݣ������˳�����
if [ "$backup_db_arr" != "" ];then
#dbnames=$(cut -d ',' -f1-5 $backup_database)
#echo "arr is (${backup_db_arr[@]})"
for dbname in ${backup_db_arr[@]}
do
echo "database $dbname backup start..."
`mkdir -p $backup_dir`
`mysqldump -h$mysql_host -P$mysql_port -u$mysql_user -p$mysql_password --databases $dbname --default-character-set=$mysql_charset | gzip > $backup_dir/$dbname-$backup_time.sql.gz`
flag=`echo $?`
if [ $flag == "0" ];then
echo "database $dbname success backup to $backup_dir/$dbname-$backup_time.sql.gz"
else
echo "database $dbname backup fail!"
fi
 
done
else
echo "ERROR:No database to backup! backup stop"
exit
fi
# ���������ɾ�����ڱ��ݣ������ɾ������
if [ "$expire_backup_delete" == "ON" -a "$backup_location" != "" ];then
#`find $backup_location/ -type d -o -type f -ctime +$expire_days -exec rm -rf {} \;`
`find $backup_location/ -type d -mtime +$expire_days | xargs rm -rf`
echo "Expired backup data delete complete!"
fi
echo "All database backup success! Thank you!"
exit
fi
