## 安装时我的配置
- root password：与Ubuntu的一样
- 用户名：carrera<br>密码同上<br>DB admin
- 服务名：MYSQL80
v
## 使用终端操作数据库
##### 1.登录数据库服务器
```
    macOS: mysql -uroot
    Windows：直接打开mysql的命令行操作
```    

##### 2.查询服务器中的数据库
```
show databases; //注意复数！
```

##### 3.选中某个数据库：
```
use OneDatabaseYouWant
select * from admin
```