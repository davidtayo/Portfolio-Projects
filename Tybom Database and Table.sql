create database tybom_products;
use tybom_products;
create schema tybom;

create table tybom.product_list (
	Product_id int primary key, 
    Product_name varchar(200) not null,
    Product_colour varchar(100) not null,
    Make_date date not null,
    Product_discount numeric(3,2) default 0
);

insert into tybom.product_list(
    Product_id,
    Product_name,
    Product_colour,
    Make_date,
    Product_discount
)
values
(
3,'Laptop', 'Red', '20210309', 0.4
),
(
4,'Fan', 'White', '20210309', 0.4
);

select * from tybom.product_list;