-- /-----------------------------creating the database-----------------------------/

create database CourierManagementSystem;
use CourierManagementSystem;

-- /-----------------------------creating the tables-----------------------------/

 create table DISTRIBUTION_CENTER(
	Center_ID varchar(12) not null,
    Staff_Count int,
    Capacity varchar(255),
    Center_Number int ,
	Street_Name varchar(40) ,
	City varchar(25) ,
    primary key (Center_ID)
);

create table COURIER(
	Courier_ID varchar(12) not null,
    Courier_NIC varchar(32) not null,
    Courier_Name varchar(255) not null,
    Courier_Phone int not null,
    Vehicle_Reg_No varchar(12) not null,
    Vehicle_Type varchar(12) ,
    Center_ID varchar(25),
    primary key (Courier_ID),
    CONSTRAINT FK_CenterID foreign key(Center_ID) 
    references DISTRIBUTION_CENTER(Center_ID) ON DELETE set null
);

 create table WAREHOUSE(
	Warehouse_ID varchar(12) not null,
    Stock_Level varchar(100),
    Capacity varchar(50),
    Inventory_status varchar(25),
    Warehouse_Number int ,
	Street_Name varchar(40) ,
	City varchar(25) ,
    primary key (Warehouse_ID)
);

CREATE TABLE EMPLOYEE (
    Employee_ID VARCHAR(12) NOT NULL,
    Employee_Name VARCHAR(100),
    Employee_NIC VARCHAR(50),
    Workplace_ID VARCHAR(12),
    Salary INT,
    Date_Of_Birth VARCHAR(40),
    Center_ID VARCHAR(12),
    Warehouse_ID VARCHAR(12),
    Manager_ID VARCHAR(12), -- Define Manager_ID column
    PRIMARY KEY (Employee_ID),
    CONSTRAINT FK_Center_ID FOREIGN KEY (Center_ID) REFERENCES 
    DISTRIBUTION_CENTER(Center_ID) ON DELETE set null,
    CONSTRAINT FK_WarehouseID FOREIGN KEY (Warehouse_ID) 
    REFERENCES WAREHOUSE(Warehouse_ID) ON DELETE set null,
    CONSTRAINT FK_ManagerID FOREIGN KEY (Manager_ID) 
    REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

 create table TRANSPORT_SERVICE(
	Transport_ID varchar(12) not null,
    Driver_ID varchar(12),
    Driver_Name varchar(60),
    Vehicle_Capacity int ,
	Vehicle_Type varchar(40) ,
	Vehicle_Reg_No varchar(25) ,
    primary key (Transport_ID)
);

 create table ITEM(
	Item_ID varchar(12) not null,
    Item_Name varchar(60),
    Item_price int ,
	Manufacturing_Company varchar(40) ,
    primary key (Item_ID)
);

create table CONTAINER(
    Delivery_Status varchar(25),
    Quantity int ,
    Item_ID varchar(12),
    Warehouse_ID varchar(12),
    Center_ID varchar(12),
    Tarnsport_ID varchar(12),
    CONSTRAINT FK_ItemID foreign key(Item_ID) 
    references ITEM(Item_ID) ON DELETE CASCADE,
    CONSTRAINT FK_Warehouse_ID foreign key(Warehouse_ID) 
    references WAREHOUSE(Warehouse_ID) ON DELETE CASCADE,
    CONSTRAINT FK_CentrID foreign key(Center_ID) 
    references DISTRIBUTION_CENTER(Center_ID) ON DELETE CASCADE,
    CONSTRAINT FK_TransportID foreign key(Tarnsport_ID) 
    references TRANSPORT_SERVICE(Transport_ID) ON DELETE CASCADE
);

 create table FLEET_MANAGEMENT(
	Maintenance_shedule varchar(50),
    Last_Maintainence_Date varchar(50),
    Courier_ID varchar(12),
	CONSTRAINT FK_CourierID foreign key(Courier_ID) 
    references COURIER(Courier_ID) ON DELETE CASCADE
);

 create table CUSTOMER(
	Customer_ID varchar(12) not null,
    Customer_Name varchar(50) not null,
    House_Number int ,
	Street_Name varchar(40) ,
	City varchar(25) ,
    primary key (Customer_ID)
);

 create table PACKAGE(
	Package_ID varchar(12) not null,
    Price varchar(50) not null,
    Delivey_Status varchar(50) not null,
    Customer_ID varchar(12),
    Courier_ID varchar(12),
    primary key (Package_ID),
	CONSTRAINT FK_CustomerID foreign key(Customer_ID) 
    references CUSTOMER(Customer_ID) ON DELETE CASCADE,
    CONSTRAINT FK_Courier_ID foreign key(Courier_ID) 
    references COURIER(Courier_ID) ON DELETE CASCADE
);

-- multivalued attribute mobile no
create table MOBILE_NUMBERS(
	Customer_ID varchar(12),
    Mobile_Number varchar(20),
	CONSTRAINT FK_Customer_ID foreign key(Customer_ID) 
    references CUSTOMER(Customer_ID) ON DELETE CASCADE
);

 create table PACKAGE_CONTENT(
	Description varchar(50) not null,
    Total_Price varchar(50) not null,
    Quantity varchar(50) not null,
    Item_ID varchar(12),
    Package_ID varchar(12),
	CONSTRAINT FK_PackageID foreign key(Package_ID) 
    references PACKAGE(Package_ID) ON DELETE CASCADE,
    CONSTRAINT FK_Item_ID foreign key(Item_ID) 
    references ITEM(Item_ID) ON DELETE CASCADE
);

 create table RECEIPT(
	Total_Amount varchar(25) not null,
    Reciept_No varchar(20) not null,
    Customer_ID varchar(12),
    CONSTRAINT FK_custID foreign key(Customer_ID) 
    references CUSTOMER(Customer_ID) ON DELETE CASCADE
);

 create table TECHNICAL_AND_CUSTOMER_SERVICE(
	Officer_ID varchar(12) not null,
    Officer_NIC varchar(20) not null,
    Contact_Number varchar(20),
    Officer_Name varchar(25) not null,
    primary key (Officer_ID)
);

create table CUSTOMER_SERVICE_CALLS(
	Officer_ID varchar(12),
    Caller_ID varchar(12),
	CONSTRAINT FK_OfficerID foreign key(Officer_ID) 
    references TECHNICAL_AND_CUSTOMER_SERVICE(Officer_ID) ON DELETE CASCADE,
	CONSTRAINT FK_CallerID foreign key(Caller_ID) 
    references CUSTOMER(Customer_ID) ON DELETE CASCADE
);

create table DISTRIBUTION_CENTER_CONTACTS(
	Officer_ID varchar(12),
    Center_ID varchar(12),
	CONSTRAINT FK_Officer_ID foreign key(Officer_ID) 
    references TECHNICAL_AND_CUSTOMER_SERVICE(Officer_ID) ON DELETE CASCADE,
	CONSTRAINT FK_Centr_ID foreign key(Center_ID) 
    references DISTRIBUTION_CENTER(Center_ID) ON DELETE CASCADE
);

-- /--------------------------Data Insertion---------------------------/

insert into DISTRIBUTION_CENTER (Center_ID, Staff_Count, Capacity, Center_Number,
 Street_Name, City) values ('DC001', 10, 'High', 1, 'Main Street', 'Colombo'),
    ('DC002', 8, 'Medium', 2, 'Galle Road', 'Kandy'),
    ('DC003', 6, 'Low', 3, 'Negombo Road', 'Galle'),
    ('DC004', 12, 'High', 4, 'Havelock Road', 'Jaffna'),
    ('DC005', 7, 'Medium', 5, 'Bullers Road', 'Matara'),
    ('DC006', 9, 'Medium', 6, 'Dharmapala Mawatha', 'Anuradhapura');

insert into COURIER (Courier_ID, Courier_NIC, Courier_Name, Courier_Phone, 
Vehicle_Reg_No, Vehicle_Type, Center_ID) values 
    ('CR001', '199901010123', 'Ravi Aruna', 771234567, 'ABC123', 'Car', 'DC001'),
    ('CR002', '198512121234', 'Samantha Perera', 778765432, 'XYZ456', 'Van', 'DC002'),
    ('CR003', '197803030345', 'Mohammed Ali', 776543219, 'DEF789', 'Bike', 'DC001'),
    ('CR004', '199008080456', 'Rukmal Perera', 770123456, 'GHI012', 'Car', 'DC003'),
    ('CR005', '199501010567', 'Dilhani Rathnayake', 779876543, 'JKL345', 'Van', 'DC002'),
    ('CR006', '198207070678', 'Lakmal Rajapakse', 774321098, 'MNO678', 'Bike', 'DC004');

insert into WAREHOUSE (Warehouse_ID, Stock_Level, Capacity, Inventory_Status, 
Warehouse_Number, Street_Name, City) values 
    ('WH001', 'High', 'Large', 'Available', 1, 'Main Street', 'Colombo'),
    ('WH002', 'Medium', 'Medium', 'Available', 2, 'Galle Road', 'Kandy'),
    ('WH003', 'Low', 'Small', 'Limited', 3, 'Negombo Road', 'Galle'),
    ('WH004', 'High', 'Large', 'Available', 4, 'Havelock Road', 'Jaffna'),
    ('WH005', 'Medium', 'Medium', 'Available', 5, 'Bullers Road', 'Matara'),
    ('WH006', 'Medium', 'Medium', 'Available', 6, 'Dharmapala Mawatha', 'Anuradhapura');

insert into EMPLOYEE (Employee_ID, Employee_Name, Employee_NIC, Workplace_ID, 
Salary, Date_Of_Birth, Center_ID, Warehouse_ID, Manager_ID)values 
    ('EMP001', 'Kamal Weerasinghe', '199001010123', 'DC001', 50000, '1990-01-01', 'DC001', 'WH001', NULL),
    ('EMP003', 'Nimal Perera', '197803030345', 'DC003', 55000, '1978-03-03', 'DC001', 'WH003', NULL);

insert into EMPLOYEE (Employee_ID, Employee_Name, Employee_NIC, Workplace_ID, Salary, 
Date_Of_Birth, Center_ID, Warehouse_ID, Manager_ID) values 
    ('EMP002', 'Saman Kumara', '198512121234', 'DC002', 45000, '1985-12-12', 'DC002', 'WH002', 'EMP001'),
    ('EMP004', 'Kasun Silva', '199008080456', 'DC001', 48000, '1990-08-08', 'DC003', 'WH004', 'EMP003'),
    ('EMP005', 'Chamari Fernando', '199501010567', 'DC002', 52000, '1995-01-01', 'DC002', 'WH005', 'EMP002'),
    ('EMP006', 'Lakmal Rajapakse', '198207070678', 'DC004', 60000, '1982-07-07', 'DC004', 'WH006', 'EMP003');

insert into TRANSPORT_SERVICE (Transport_ID, Driver_ID, Driver_Name, Vehicle_Capacity, 
Vehicle_Type, Vehicle_Reg_No) values 
    ('TS001', 'DR001', 'Samantha Silva', 5000, 'Truck', 'TRK001'),
    ('TS002', 'DR002', 'Nimal Perera', 3000, 'Van', 'VAN002'),
    ('TS003', 'DR003', 'Kamal Fernando', 2000, 'Car', 'CAR003'),
    ('TS004', 'DR004', 'Ravi Rajapakse', 5000, 'Truck', 'TRK004'),
    ('TS005', 'DR005', 'Samantha Silva', 3000, 'Van', 'VAN005'),
    ('TS006', 'DR006', 'Nuwan Bandara', 2000, 'Car', 'CAR006');

insert into ITEM (Item_ID, Item_Name, Item_price, Manufacturing_Company) values 
    ('ITM001', 'Laptop', 1000, 'Dell'),
    ('ITM002', 'Mobile Phone', 800, 'Samsung'),
    ('ITM003', 'Headphones', 50, 'Apple'),
    ('ITM004', 'Smartwatch', 200, 'Apple'),
    ('ITM005', 'Tablet', 500, 'Samsung'),
    ('ITM006', 'Printer', 300, 'HP');


insert into CONTAINER (Delivery_Status, Quantity, Item_ID, Warehouse_ID, Center_ID, Tarnsport_ID) 
values ('In Transit', 50, 'ITM001', 'WH001', 'DC001', 'TS001'),
    ('Delivered', 100, 'ITM002', 'WH002', 'DC002', 'TS002'),
    ('In Warehouse', 30, 'ITM003', 'WH006', 'DC003', 'TS003'),
    ('In Transit', 20, 'ITM004', 'WH004', 'DC002', 'TS004'),
    ('Delivered', 80, 'ITM005', 'WH002', 'DC005', 'TS001'),
    ('In Warehouse', 40, 'ITM006', 'WH006', 'DC005', 'TS002');

insert into FLEET_MANAGEMENT (Maintenance_shedule, Last_Maintainence_Date, Courier_ID) 
values ('Monthly', '2023-12-01', 'CR001'),
    ('Quarterly', '2024-01-15', 'CR002'),
    ('Bi-annually', '2023-11-10', 'CR003'),
    ('Monthly', '2024-02-20', 'CR004'),
    ('Annually', '2023-09-05', 'CR002'),
    ('Bi-annually', '2023-10-10', 'CR001');

insert into CUSTOMER (Customer_ID, Customer_Name, House_Number, Street_Name, City) 
values ('CUST001', 'Saman Perera', 123, 'Main Street', 'Colombo'),
    ('CUST002', 'Nuwan Bandara', 456, 'Galle Road', 'Kandy'),
    ('CUST003', 'Kamal Rathnayake', 789, 'Negombo Road', 'Galle'),
    ('CUST004', 'Chamari Silva', 321, 'Havelock Road', 'Jaffna'),
    ('CUST005', 'Ravi Rajapakse', 654, 'Bullers Road', 'Galle'),
    ('CUST006', 'Nimal Fernando', 987, 'Dharmapala Mawatha', 'Anuradhapura');

insert into PACKAGE (Package_ID, Price, Delivey_Status, Customer_ID, Courier_ID) 
values ('PKG001', '50', 'Delivered', 'CUST001', 'CR001'),
    ('PKG002', '30', 'In Transit', 'CUST002', 'CR002'),
    ('PKG003', '70', 'Delivered', 'CUST003', 'CR003'),
    ('PKG004', '25', 'In Transit', 'CUST004', 'CR004'),
    ('PKG005', '40', 'Delivered', 'CUST005', 'CR005'),
    ('PKG006', '60', 'In Transit', 'CUST006', 'CR006');

insert into MOBILE_NUMBERS (Customer_ID, Mobile_Number) values 
	('CUST001', '7712345678'),
    ('CUST002', '7787654321'),
    ('CUST003', '7765432198'),
    ('CUST004', '7701234567'),
    ('CUST004', '7798712654'),
    ('CUST005', '7798765432'),
    ('CUST006', '7743210987');

insert into PACKAGE_CONTENT (Description, Total_Price, Quantity, Item_ID, Package_ID) 
values ('Electronics', '50000', '5', 'ITM001', 'PKG001'),
    ('Accessories', '15000', '3', 'ITM002', 'PKG002'),
    ('Electronics', '35000', '7', 'ITM003', 'PKG003'),
    ('Electronics', '20000', '2', 'ITM002', 'PKG004'),
    ('Electronics', '40000', '4', 'ITM005', 'PKG005'),
    ('Accessories', '12000', '6', 'ITM005', 'PKG004');

insert into RECEIPT (Total_Amount, Reciept_No, Customer_ID) 
values ('5000', 'RCPT001', 'CUST001'),
    ('3000', 'RCPT002', 'CUST002'),
    ('7040', 'RCPT003', 'CUST003'),
    ('25000', 'RCPT004', 'CUST001'),
    ('4000', 'RCPT005', 'CUST005'),
    ('6000', 'RCPT006', 'CUST001');

insert into TECHNICAL_AND_CUSTOMER_SERVICE (Officer_ID, Officer_NIC, Contact_Number, Officer_Name) 
values ('TECH001', '199001010123', '7712345678', 'Ravi Perera'),
    ('TECH002', '198512121234', '7787654321', 'Samantha Silva'),
    ('TECH003', '197803030345', '7765432198', 'Mohammed Ali'),
    ('TECH004', '199008080456', '7701234567', 'Rukmal Perera'),
    ('TECH005', '199501010567', '7798765432', 'Dilhani Rathnayake'),
    ('TECH006', '198207070678', '7743210987', 'Lakmal Rajapakse');

insert into CUSTOMER_SERVICE_CALLS (Officer_ID, Caller_ID) values 
    ('TECH001', 'CUST001'),
    ('TECH002', 'CUST002'),
    ('TECH003', 'CUST003'),
    ('TECH004', 'CUST004'),
    ('TECH005', 'CUST005'),
    ('TECH006', 'CUST006');

insert into DISTRIBUTION_CENTER_CONTACTS (Officer_ID, Center_ID) values 
    ('TECH001', 'DC001'),
    ('TECH002', 'DC002'),
    ('TECH003', 'DC003'),
    ('TECH004', 'DC004'),
    ('TECH005', 'DC005'),
    ('TECH006', 'DC006');
    
-- /------------------------------------------------Update data in the tables-----------------------------------------------------/

update DISTRIBUTION_CENTER set Staff_Count = 15, City = 'Colombo' where Center_ID = 'DC001';

update DISTRIBUTION_CENTER set Street_Name = 'Perahera Mawatha' where Center_ID = 'DC002';

update COURIER set Courier_Phone = 771234567 where Courier_ID = 'CR001';

update COURIER set Vehicle_Reg_No = 'LMN789' where Courier_ID = 'CR002';

update WAREHOUSE set Capacity = 'Large', City = 'Colombo' where Warehouse_ID = 'WH001';

update WAREHOUSE set Inventory_Status = 'Available' where Warehouse_ID = 'WH002';

update EMPLOYEE set Salary = 60000 where Employee_ID = 'EMP001';

update EMPLOYEE set Date_Of_Birth = '1985-12-12' where Employee_ID = 'EMP002';

update TRANSPORT_SERVICE set Vehicle_Capacity = 6000 where Transport_ID = 'TS001';

update TRANSPORT_SERVICE set Vehicle_Type = 'Van' where Transport_ID = 'TS002';

update ITEM set Item_price = 1200 where Item_ID = 'ITM001';

update ITEM set Manufacturing_Company = 'Sri Lanka Electronics' where Item_ID = 'ITM002';

update CONTAINER set Delivery_Status = 'Delivered' where Center_ID = 'DC001';

update CONTAINER set Quantity = 25 where Center_ID = 'DC002';

update FLEET_MANAGEMENT set Maintenance_shedule = 'Monthly' where Courier_ID = 'CR001';

update FLEET_MANAGEMENT set Last_Maintainence_Date = '2024-03-15' where Courier_ID = 'CR002';

update CUSTOMER set House_Number = 456 where Customer_ID = 'CUST001';

update CUSTOMER set City = 'Kandy' where Customer_ID = 'CUST002';

update PACKAGE set Price = 35 where Package_ID = 'PKG001';

update PACKAGE set Delivey_Status = 'In Transit' where Package_ID = 'PKG002';

update MOBILE_NUMBERS set Mobile_Number = '7787654321' 
where Customer_ID = 'CUST001' AND Mobile_Number = '7712345678';

update MOBILE_NUMBERS set Mobile_Number = '7700011125' where Customer_ID = 'CUST005';

update PACKAGE_CONTENT set Description = 'Accessories' where Package_ID = 'PKG001';

update PACKAGE_CONTENT set Total_Price = '250' where Package_ID = 'PKG002';

update RECEIPT set Total_Amount = '5500' where Customer_ID = 'CUST001';

update RECEIPT set Reciept_No = 'RCPT002' where Customer_ID = 'CUST002';

UPDATE TECHNICAL_AND_CUSTOMER_SERVICE set Contact_Number = '7712345678' where Officer_ID = 'TECH001';

update TECHNICAL_AND_CUSTOMER_SERVICE set Officer_Name = 'Eva Johnson' where Officer_ID = 'TECH002';

update CUSTOMER_SERVICE_CALLS set Caller_ID = 'CUST002' where Officer_ID = 'TECH002';

update CUSTOMER_SERVICE_CALLS set Caller_ID = 'CUST003' where Officer_ID = 'TECH003';

update DISTRIBUTION_CENTER_CONTACTS set Center_ID = 'DC002' where Officer_ID = 'TECH002';

update DISTRIBUTION_CENTER_CONTACTS set Center_ID = 'DC003' where Officer_ID = 'TECH003';

-- /----------------------------------------Delete a row in each table---------------------------------------/

delete from DISTRIBUTION_CENTER where Center_ID = 'DC001';

delete from COURIER where Courier_ID = 'CR001';

delete from WAREHOUSE where Warehouse_ID = 'WH001';

delete from EMPLOYEE where Employee_ID = 'EMP001';

delete from TRANSPORT_SERVICE where Transport_ID = 'TS001';

delete from ITEM where Item_ID = 'ITM001';

delete from CONTAINER where Center_ID = 'DC001';

delete from FLEET_MANAGEMENT where Courier_ID = 'CR001';

delete from CUSTOMER where Customer_ID = 'CUST001';

delete from PACKAGE where Package_ID = 'PKG001';

delete from MOBILE_NUMBERS where Customer_ID = 'CUST001' AND Mobile_Number = '7712345678';

delete from PACKAGE_CONTENT where Package_ID = 'PKG001';

delete from RECEIPT where Customer_ID = 'CUST001';

delete from TECHNICAL_AND_CUSTOMER_SERVICE where Officer_ID = 'TECH001';

delete from CUSTOMER_SERVICE_CALLS where Officer_ID = 'TECH001';

delete from DISTRIBUTION_CENTER_CONTACTS where Officer_ID = 'TECH001';

-- /--------------------------------------7 Simple Queries to Retrieve Data---------------------------------------/
SELECT * FROM DISTRIBUTION_CENTER;

SELECT Courier_ID, Courier_Name, Vehicle_Type FROM COURIER;

SELECT * FROM COURIER cross join PACKAGE;

CREATE VIEW Customer_Packages As SELECT * FROM CUSTOMER natural join PACKAGE;

SELECT Courier_ID AS ID, Courier_Name AS Name FROM COURIER;

SELECT AVG(Salary) AS Average_Salary FROM EMPLOYEE;

SELECT * FROM CUSTOMER where Customer_Name LIKE 'N%';



-- /--------------------------------------13 complex Queries to Retrieve Data---------------------------------------/
SELECT Courier_ID, Courier_NIC, Courier_Name FROM COURIER
UNION
SELECT Employee_ID, Employee_NIC, Employee_Name FROM EMPLOYEE;

SELECT Warehouse_ID,Stock_Level, Inventory_Status FROM WAREHOUSE WHERE Stock_Level='Medium'
INTERSECT
SELECT Warehouse_ID,Stock_Level, Inventory_Status FROM WAREHOUSE WHERE Inventory_Status='Available';




SELECT * FROM EMPLOYEE WHERE Center_ID IN (SELECT Center_ID FROM DISTRIBUTION_CENTER WHERE City = 'Kandy');

CREATE VIEW mgs AS SELECT e.Employee_Name, e.Salary, m.Employee_Name AS Manager_Name
FROM EMPLOYEE as e
LEFT JOIN EMPLOYEE as m ON e.Manager_ID = m.Employee_ID;
SELECT * FROM mgs;

SELECT pc.Description AS Item_Name, pc.Total_Price AS Item_Price, p.Package_ID
FROM PACKAGE_CONTENT as pc
JOIN PACKAGE as p ON pc.Package_ID = p.Package_ID;

SELECT f.Maintenance_shedule, f.Last_Maintainence_Date, c.Courier_Name
FROM FLEET_MANAGEMENT as f
JOIN COURIER as c ON f.Courier_ID = c.Courier_ID;

SELECT i.Item_Name, SUM(c.Quantity) AS Total_Quantity
FROM CONTAINER as c
JOIN ITEM as i ON c.Item_ID = i.Item_ID
GROUP BY i.Item_Name;

SELECT c.Customer_Name, SUM(r.Total_Amount) AS Total_Amount_Paid
FROM CUSTOMER as c
JOIN RECEIPT as r ON c.Customer_ID = r.Customer_ID
GROUP BY c.Customer_Name;

SELECT tcs.Officer_Name, tcs.Contact_Number, dc.City AS Distribution_Center
FROM TECHNICAL_AND_CUSTOMER_SERVICE as tcs
JOIN DISTRIBUTION_CENTER_CONTACTS as dcc ON tcs.Officer_ID = dcc.Officer_ID
JOIN DISTRIBUTION_CENTER as dc ON dcc.Center_ID = dc.Center_ID;

SELECT i.Item_Name, c.Quantity, c.Delivery_Status
FROM CONTAINER as c
JOIN ITEM as i ON c.Item_ID = i.Item_ID
WHERE c.Delivery_Status = 'In Transit';

SELECT e.Employee_Name, e.Employee_NIC, dc.City
FROM EMPLOYEE as e
JOIN DISTRIBUTION_CENTER as dc ON e.Center_ID = dc.Center_ID;

SELECT c.Customer_Name, m.Mobile_Number, p.Delivey_Status
FROM CUSTOMER as c
JOIN MOBILE_NUMBERS as m ON c.Customer_ID = m.Customer_ID
JOIN PACKAGE as p ON c.Customer_ID = p.Customer_ID;

SELECT i.Item_Name, c.Quantity
FROM CONTAINER as c
JOIN ITEM as i ON c.Item_ID = i.Item_ID
JOIN WAREHOUSE as w ON c.Warehouse_ID = w.Warehouse_ID
WHERE w.Stock_Level = 'High';

SELECT c.Courier_Name, c.Courier_ID, dc.City AS Distribution_Center
FROM COURIER as c
JOIN DISTRIBUTION_CENTER as dc ON c.Center_ID = dc.Center_ID;

CREATE VIEW customer_pakages as SELECT c.Customer_Name, c.Customer_ID, SUM(pc.Quantity) AS Total_Item_Quantity
FROM CUSTOMER as c
JOIN PACKAGE as p ON c.Customer_ID = p.Customer_ID
JOIN PACKAGE_CONTENT as pc ON p.Package_ID = pc.Package_ID
GROUP BY c.Customer_Name, c.Customer_ID;
SELECT * FROM customer_pakages;