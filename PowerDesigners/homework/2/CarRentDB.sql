-- Database: CarRentDB

-- DROP DATABASE "CarRentDB";

CREATE DATABASE CarRentDB;

--------------
--创建表--
--------------
--客户
CREATE TABLE CLIENT (
	 ClientID CHAR(13) PRIMARY KEY,
	 ClientName VARCHAR(10) NOT NULL,
	 ClientGender CHAR(2) NULL,
	 ClientPID CHAR(18) NOT NULL,
	 ClientTel VARCHAR(11) NOT NULL
);
--汽车信息
CREATE TABLE CAR (
 	 CarID CHAR(13) PRIMARY KEY,
 	 CarBrand VARCHAR(10) NOT NULL,
 	 CarModel VARCHAR(10) NOT NULL,
 	 CarSeat CHAR(3) NOT NULL
);
--租赁价格
CREATE TABLE RENT_PRICE (
	 CarID CHAR(13) NOT NULL,
	 RentPrice MONEY NOT NULL,
	 CONSTRAINT CarID_FK FOREIGN KEY(CarID) REFERENCES CAR(CarID) ON DELETE 
CASCADE
);
--租赁登记
CREATE TABLE RENT_REG (
	 RegID SERIAL PRIMARY KEY,
	 ClientID CHAR(13) NOT NULL,
	 CarID CHAR(13) NOT NULL,
	 RentDate DATE NOT NULL,
	 ReturnDate DATE NOT NULL
);
--租赁费用
CREATE TABLE RENT_FEE(
	 FeeID SERIAL PRIMARY KEY,
	 ClientID CHAR(13) NOT NULL,
	 CarID CHAR(13) NOT NULL,
	 RentDays INTEGER,
	 RentPrice MONEY NOT NULL,
	 TotalFee MONEY NOT NULL
);

--------------
--- 插入样本
--------------
INSERT INTO CLIENT VALUES('2021050110001', '小红', '女', '511111200109092321', '11111111111');
INSERT INTO CLIENT VALUES('2021050110002', '小明', '男', '511111200009094234', '15468768561');

INSERT INTO CAR VALUES('2021050120001', '法拉利', '488', '5');
INSERT INTO CAR VALUES('2021050120002', '兰博', 'hurican', '5');

INSERT INTO RENT_PRICE VALUES('2021050120001', '50000');
INSERT INTO RENT_PRICE VALUES('2021050120002', '25000');

INSERT INTO RENT_REG VALUES(DEFAULT, '2021050110001', '2021050120001', '2021-05-01', '2021-05-02');
INSERT INTO RENT_REG VALUES(DEFAULT, '2021050110002', '2021050120002', '2021-05-01', '2021-05-02');

INSERT INTO RENT_FEE VALUES(DEFAULT, '2021042410001', '2021042420001', '1', '500', '500');
INSERT INTO RENT_FEE VALUES(DEFAULT, '2021042410002', '2021042420002', '8', '250', '2000');

--------------
--创建用户角色--
--------------
--客户
CREATE ROLE "R_Client" WITH
	NOSUPERUSER
	LOGIN
	ENCRYPTED PASSWORD '23456'
	CONNECTION LIMIT -1;
--业务员
CREATE ROLE "R_Salesman" WITH
	NOSUPERUSER
	LOGIN
	ENCRYPTED PASSWORD 'ALESMAN_PASS'
	CONNECTION LIMIT -1;
--经理
CREATE ROLE "R_Manager" WITH
	NOSUPERUSER
	LOGIN
	ENCRYPTED PASSWORD 'ANAGER_PASS'
	REPLICATION
	CREATEROLE
	CONNECTION LIMIT -1;
--管理员
CREATE ROLE "R_Adminastrator" WITH
	SUPERUSER
	LOGIN
	ENCRYPTED PASSWORD 'ANAGER_PASS'
	REPLICATION
	CREATEROLE
	CREATEDB
	BYPASSRLS
	CONNECTION LIMIT -1;
	
------------
--- 角色权限
------------
-- 管理员
GRANT SELECT,INSERT,UPDATE,DELETE ON CLIENT TO "R_Adminstrator";
GRANT SELECT,INSERT,UPDATE,DELETE ON CAR TO "R_Adminstrator";
GRANT SELECT,INSERT,UPDATE,DELETE ON RENT_PRICE TO "R_Adminstrator";
GRANT SELECT,INSERT,UPDATE,DELETE ON RENT_REG TO "R_Adminstrator";
GRANT SELECT,INSERT,UPDATE,DELETE ON RENT_FEE TO "R_Adminstrator";

-- 经理
GRANT SELECT,INSERT,UPDATE,DELETE ON CLIENT TO "R_Manager";
GRANT SELECT,INSERT,UPDATE,DELETE ON CAR TO "R_Manager";
GRANT SELECT,INSERT,UPDATE,DELETE ON RENT_PRICE TO "R_Manager";
GRANT SELECT,INSERT,UPDATE,DELETE ON RENT_REG TO "R_Manager";
GRANT SELECT,INSERT,UPDATE,DELETE ON RENT_FEE TO "R_Manager";

-- 客户
GRANT SELECT,UPDATE ON CLIENT TO "R_Client";
GRANT SELECT ON CAR TO "R_Client";
GRANT SELECT ON RENT_PRICE TO "R_Client";
GRANT SELECT ON RENT_REG TO "R_Client";
GRANT SELECT ON RENT_FEE TO "R_Client";

-- 销售员
GRANT SELECT ON CLIENT TO "R_SalesMan";
GRANT SELECT ON CAR TO "R_SalesMan";
GRANT SELECT ON RENT_PRICE TO "R_SalesMan";
GRANT SELECT,INSERT,UPDATE,DELETE ON RENT_REG TO "R_SalesMan";
GRANT SELECT,INSERT,UPDATE,DELETE ON RENT_FEE TO "R_SalesMan";

---------
---用户
---------
CREATE USER "ClientUser";

CREATE USER "SalesManUser";

CREATE USER "ManagerUser";

CREATE USER "AdminstratorUser";

-------------------
--用户权限管理
-------------------
GRANT "R_Client" TO "ClientUser";
GRANT "R_SalesMan" TO "SalesManUser";
GRANT "R_Manager" TO "ManagerUser";
GRANT "R_Adminstrator" TO "AdminstratorUser";


