# 自动重启

## 一个可以检测服务器当前获取到的IP并在其变化时重启服务器的脚本

适用于家庭网络，由于大多为动态IP，往往会导致IP在变化时服务器无法连接或超时，这个脚本用于自动重启服务器以刷新获取到的IP(重新分配)

建议设定为每5分钟执行一次

使用方法：
1. 解压脚本到根目录下
2. 打开系统 crontab（crontab -e）
3. 添加“*/5 * * * * /ipr/iprs.sh”
4. 进入到 ipbox 目录下
5. 授予 iprs.sh 权限（chmod +x iprs.sh ）

**注意要先按照 iprc.sh 内的提示修改相关配置**