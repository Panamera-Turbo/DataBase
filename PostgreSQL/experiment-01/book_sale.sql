-- 4.在数据库BookSale中，采用PL/pgSQL语言编写存储过程函数Pro_CurrentSale，实现 当日图书销售量 及 销售金额汇总 统计。

-- 5.在数据库BookSale中，采用PL/pgSQL语言编写过程语句块，实现对存储过程函数Pro_CurrentSale的调用，并输出统计结果。

-- 6.在数据库BookSale中，采用PL/pgSQL语言编写编写图书销售表Insert触发器Tri_InsertSale，实现图书库存数据同步修改处理。

-- 7.在数据库BookSale中，对图书销售表Insert触发器Tri_InsertSale程序进行功能验证。

-- 8.在数据库BookSale中，创建存储过程函数实现图书销售数量和金额统计。



-- drop database BookSale;

---------------------------------------------------
------          创建            -------------------
---------------------------------------------------

create database BookSale
    with
    encoding = UTF8;

-- 书籍表
create table BookInfo
(   
    BookName varchar(20) not null,          -- 书名  
    BookAuthor varchar(20) not null,        -- 作者
    BookPrice money not null,               -- 单价
    BookProfit money not null,              -- 单本毛利润
    BookPublisher varchar(30) not null,     -- 出版社
    BookLeft integer not null default 0,    -- 剩余数目
    BookID char(20) primary key             -- 索书号
);

-- 书籍销售信息
create table BookSaleInfo
(
    BookID char(20) not null,                  -- 索书号
    SaleID char(18) primary key,               -- 订单号
    SaleTime text not null,                    -- 时间
    SaleCount integer not null default 1,      -- 销量
    constraint BookSale_FK foreign key(BookID) -- 外键定义，BookInfo里的BookID，级联删除
    references BookInfo(BookID)
        on delete cascade
);

-- 展示给消费者的视图
-- 包含书名，作者，出版社，单价
-- 只展示余量大于0的书
create view BookInfoCus as  
select BookName, BookAuthor, BookPrice, BookPublisher
  from BookInfo
 where BookLeft > 0;

-- 建立索引，依靠索书号
create unique index BookIndex on BookInfo (BookID);

-----------------------------------------------------------
-----------           增删查改操作       -------------------
-----------------------------------------------------------
-- 增
insert into BookInfo
values ('微积分学习指导', '喻伟', 40, 25, '电子科技大学出版社', 99, 'ISBN2387492793247332');

insert into BookInfo
values ('数据库系统设计与原理', '李政康', 59, 40, '人们邮电出版社', 100, 'ISBN7992748279234742');

insert into BookSaleInfo
values ('ISBN2387492793247332', '202009142203490001','2020-09-14', 8);

insert into BookSaleInfo
values ('ISBN7992748279234742', '202009142203490002', '2020-09-14', 10);

insert into BookInfo
values ('数据库系统设计与原理-错误版本待删除', '李政康', 59, 40, '人们邮电出版社', 1, 'ISBN7992748279234749');

insert into BookSaleInfo
values ('ISBN7992748279234749', '202009142203490000', '2020-09-14', 1);
-- 删

delete from BookInfo
 where BookName = '数据库系统设计与原理-错误版本待删除';

delete from BookInfo
 where BookLeft < 0;

-- 查

select BookName, BookPrice
  into BookPriceTable
  from BookInfo
 where BookLeft > 0
 order by BookPrice;

-- 改

update BookSaleInfo
   set SaleCount = 10
 where BookID = 'ISBN2387492793247332';

update BookInfo
   set BookLeft = 89
 where BookID = 'ISBN2387492793247332';

--------------------------------------------
----------     存储过程     ----------------
--------------------------------------------
create or replace function Pro_CurrentSale(date text, INOUT TotalSale integer default 0, INOUT TotalIncome money default 0)
returns record as $$
declare
  sc record;
  Bprice money := 0;
begin
  for sc in (select SaleCount, BookID from BookSaleInfo where SaleTime = date) loop
    Bprice := (select BookPrice from BookInfo where BookID = sc.BookID);
    TotalSale := TotalSale + sc.SaleCount;
    TotalIncome := TotalIncome + sc.SaleCount * Bprice;
  end loop; 
end;
$$ language plpgsql;

-- 调用
select Pro_CurrentSale('2020-09-14');   

------------------------------------------------
-------------   触发器    ------------
-------------------------------------------------
create or replace function insert_sale() 
  returns trigger as $insert_sale$
  begin
    update BookInfo
       set BookLeft = BookLeft - NEW.SaleCount
     where BookID = NEW.BookID;
    return NEW;
  end;
$insert_sale$ language plpgsql;

create trigger Tri_InsertSale
after insert on BookSaleInfo
for each row execute procedure insert_sale();

-- test
insert into BookSaleInfo
values ('ISBN7992748279234742', '202009142203490003', '2020-09-14', 1);

select * from BookInfo;

--------------------------------------------
--------------------------------------------
-----------    实验二内容    ----------------
--------------------------------------------
--------------------------------------------

------------------------------------------------------
---- 创建客户（R_Customer）、商家（R_Seller）角色  -----
------------------------------------------------------



------------------------------------------------------
--为R_Customer、R_Seller角色赋予数据库对象权限
------------------------------------------------------




------------------------------------------------------
-- 创建客户用户U_Customer、商家用户U_Seller
------------------------------------------------------




------------------------------------------------------
--为客户用户U_Customer、商家用户U_Seller分派客户（R_Client）、商家（R_Seller）角色
------------------------------------------------------





------------------------------------------------------
--以客户用户U_Customer、商家用户U_Seller身份访问图书销售管理数据库
------------------------------------------------------





