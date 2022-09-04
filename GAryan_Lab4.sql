drop database E_Commerce;
create database E_Commerce;
use E_Commerce;
create table Supplier
( 
Supp_id int primary key,
Supp_Name varchar(50)not null,
Supp_City varchar(50)not null,
Supp_Phone varchar(50)not null);

create table Customer
(
Cus_Id int primary key,
Cus_Name varchar (20) not null,
Cus_Phone varchar(10) not null,
Cus_City varchar (30) not null,
Cus_Gender char );

Create table category
(
Cat_Id int primary key,
Cat_Name varchar (20) not null);

Create table product
(
Pro_Id int primary key,
Pro_Name varchar(20) not null default "Dummy",
Pro_Desc varchar(60),
Cat_Id int,
 Foreign key(Cat_Id) References category(Cat_Id));
 
CREATE TABLE IF NOT EXISTS supplier_pricing (
Pricing_Id int not null,
Pro_Id int not null,
Supp_Id int not null,
Supp_Price int DEFAULT 0,
primary key (Pricing_Id),
FOREIGN KEY (Pro_Id) REFERENCES Product (Pro_Id),
FOREIGN KEY (Supp_Id) REFERENCES Supplier(Supp_Id)
);

create table Order1
(
Ord_Id int primary key,
Ord_Amount int not null,
Ord_Date date not null,
Cus_Id int,
Foreign key (Cus_ID) references Customer (Cus_ID),
Pricing_Id int,
Foreign key(Pricing_Id) references Supplier_Pricing(Pricing_Id)
);


create table rating
(
Rat_Id int primary key,
Ord_Id int,
Foreign key(Ord_Id) references Order1(Ord_Id),
Rat_Ratstars int not null);

insert into Supplier values(1, "Rajesh Retails",'Delhi', 1234567890);
insert into Supplier values(2, "Appario Ltd.", 'Mumbai', 2589631470);
insert into Supplier values(3, "Knome products", 'Bangalore',9785462315);
insert into Supplier values(4, "Bansal Retails", 'Kochi', 8975463285);
insert into Supplier values(5, "Mittal Ltd.", 'Lucknow', 7898456532);

insert into Customer values(1, "Aakash","9999999999", "Delhi","M");
insert into Customer values(2, "Aman","9785463215", "Noida", "M");
insert into Customer values(3, "Neha","9999999988", "Mumbai", "F");
insert into Customer values(4, "Megha","9994562399", "Kolkata", "F");
insert into Customer values(5, "Pulkit","7895999999", "Lucknow", "M");

insert into Category values(1, 'Books');
insert into Category values(2, 'Games');
insert into Category values(3, 'Groceries');
insert into Category values(4, 'Electronics');
insert into Category values(5, 'Clothes');

insert into Product values(1,'GTA V','Windows7 and above with i5 processor and 8GB RAM', 2);
insert into Product values(2, 'SHIRT', 'SIZE-L with Black, Blue and White variations', 5);
insert into Product values(3, 'Rog Laptop','Windows 10 with 15inch screen,i7 processor, 1TB SSD', 4);
insert into Product values(4, 'OATS','Highly Nutritious from Nestle', 3);
insert into Product values(5, 'HARRY POTTER','Best Collection of all time by J.K Rowling', 1);
insert into Product values(6, 'Milk','1L Toned MIlk', 3);
insert into Product values(7, 'Boat Earphones','1.5Meter long Dolby Atmos', 4);
insert into Product values(8, 'Jeans','Stretchable Denim Jeans with various sizes and color', 5);
insert into Product values(9, 'Project IGI','compatible with windows 7 and above', 2);
insert into Product values(10, 'Hoodie','Black GUCCI for 13 yrs and above', 5);
insert into Product values(11, 'Rich Dad Poor Dad','Written by RObert Kiyosaki',1);
insert into Product values(12, 'Train Your Brain','By Shireen Stephen', 1);

insert into Supplier_Pricing values(1,'1','2','1500');
insert into Supplier_Pricing values(2,"3","5","30000");
insert into Supplier_Pricing values(3,"5","1","3000");
insert into Supplier_Pricing values(4,"2","3","2500");
insert into Supplier_Pricing values(5,"4","1","1000");


INSERT INTO Order1 VALUES(101,1500,"2021-10-06",2,1);
INSERT INTO Order1 VALUES(102,1000,"2021-10-12",3,5);
INSERT INTO Order1 VALUES(103,30000,"2021-09-16",5,2);
INSERT INTO Order1 VALUES(104,1500,"2021-10-05",1,1);
INSERT INTO Order1 VALUES(105,3000,"2021-08-16",4,3);
INSERT INTO Order1 VALUES(106,1450,"2021-08-18",1,1);
INSERT INTO Order1 VALUES(107,789,"2021-09-01",3,5);
INSERT INTO Order1 VALUES(108,780,"2021-09-07",5,1);
INSERT INTO Order1 VALUES(109,3000,"2021-09-10",5,3);
INSERT INTO Order1 VALUES(110,2500,"2021-09-10",2,4);
INSERT INTO Order1 VALUES(111,1000,"2021-09-15",4,5);
INSERT INTO Order1 VALUES(112,789,"2021-09-16",4,2);
INSERT INTO Order1 VALUES(113,31000,"2021-09-16",1,3);
INSERT INTO Order1 VALUES(114,1000,"2021-09-16",3,5);
INSERT INTO Order1 VALUES(115,3000,"2021-09-16",5,3);
INSERT INTO Order1 VALUES(116,99,"2021-09-17",2,4);



insert into rating values(1,101,4);
insert into rating values(2,102,3);
insert into rating values(3,103,1);
insert into rating values(4,104,2);
insert into rating values(5,105,4);
insert into rating values(6,106,3);
insert into rating values(7,107,4);
insert into rating values(8,108,4);
insert into rating values(9,109,3);
insert into rating values(10,110,5);
insert into rating values(11,111,3);
insert into rating values(12,112,4);
insert into rating values(13,113,2);
insert into rating values(14,114,1);
insert into rating values(15,115,1);
insert into rating values(16,116,0);

#3;Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.

SELECT count(t2.Cus_Gender) as NoOfCustomers, t2.Cus_Gender FROM
(SELECT t1.Cus_Id, t1.Cus_Gender, t1.Ord_Amount, t1.Cus_Name FROM
(SELECT `Order1`.*, Customer.Cus_Gender, Customer.Cus_Name FROM `Order1` INNER JOIN Customer WHERE `Order1`.Cus_Id=Customer.Cus_Id having
`Order1`.Ord_Amount>=3000)
as t1 group by t1.Cus_Id) as t2 group by t2.Cus_Gender;

#4-Display all the orders along with product name ordered by a customer having Customer_Id=2
select product.Pro_Name, `Order1`.* from `order1`, supplier_pricing, product
where `order1` .Cus_Id =  2 and `Order1`.Pricing_Id = supplier_pricing.pricing_Id and supplier_pricing.Pro_Id = product.Pro_Id;

#5)	Display the Supplier details who can supply more than one product.
select Supplier.* from Supplier where Supplier.Supp_Id in
(select Supp_Id from supplier_pricing group by Supp_id having
count(Supp_Id)>1)
group by Supplier.Supp_Id;
select * from Supplier

#6)	Find the least expensive product from each category and print the table with category id, name, product name and price of the product
select category.Cat_Id,category.Cat_Name, MIN(t3.Min_Price) as Min_Price FROM category INNER JOIN
(select product.Cat_Id, product.Pro_Name, t2.* FROM product INNER JOIN
(select Pro_Id, MIN(Supp_Price) AS Min_Price FROM supplier_pricing GROUP BY Pro_Id)
AS t2 WHERE t2.Pro_Id = product.Pro_Id)
AS t3 WHERE t3.Cat_Id = category.Cat_Id GROUP BY t3.Cat_Id;
select * from category 

#7)	Display the Id and Name of the Product ordered after 2021-10-05
select product.Pro_Id, product.Pro_Name FROM `Order1` INNER JOIN 
supplier_pricing ON supplier_pricing.Pricing_Id=`Order1`.Pricing_Id INNER JOIN product
ON product.Pro_Id=supplier_pricing.Pro_Id WHERE `Order1`.Ord_Date > "2021-10-05";

#8)	Display customer name and gender whose names start or end with character 'A'.
SELECT Customer.Cus_Name,Customer.Cus_Gender FROM Customer WHERE Customer.Cus_Name LIKE
'A%' OR Customer.Cus_Name LIKE '%A';
SELECT Cust_Name, Cus_Gender FROM Customer WHERE Cust_Name LIKE 'A%' OR Cust_Name LIKE '%A' ;
SELECT * FROM supplier;
SELECT * FROM RATING;

#9)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.
DELIMITER //
Create Procedure  GetAllProducts()
Begin
SELECT Supp_Id, Supp_Name, Rat_Ratstars FROM Supplier, rating;
END //
DELIMITER ;


 




