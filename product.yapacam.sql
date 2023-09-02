CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
);

INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

-- 1.1 Mağazadaki tüm ürünlerin adlarını seçin.
select name from products
-- 1.2 Mağazadaki tüm ürünlerin adlarını ve fiyatlarını seçin.
select name,Price from products
-- 1.3 Fiyatı 200$ veya daha düşük olan ürünlerin adını seçin.
select name from products where Price <=200;
-- 1.4 Fiyatı 60$ ile 120$ arasında olan tüm ürünleri seçin.
select * from products where Price between 60 and 120;
-- 1.5 Adı ve fiyatı sent cinsinden seçin (yani, fiyat 100 ile çarpılmalıdır).
select name,(Price * 100) as sent from products;

-- 1.6 Tüm ürünlerin ortalama fiyatını hesaplayın.
select name, round(avg(Price),2) from products group by name;
-- 1.7 Üretici kodu 2 olan tüm ürünlerin ortalama fiyatını hesaplayınız.
select round(avg(Price),2)from products where Manufacturer=2;
-- 1.8 Fiyatı 180$'a eşit veya daha yüksek olan ürünlerin sayısını hesaplayın.
SELECT COUNT(*) FROM products WHERE Price >= 180;
-- 1.9 Fiyatı 180$ veya daha yüksek olan tüm ürünlerin adını ve fiyatını seçin ve 
--önce fiyata göre (azalan düzende), ardından ada göre (artan düzende) sıralayın.
select name,Price from products where Price >=180 order by Price desc, name asc;

-- 1.10 Her bir ürünün üreticisine ilişkin tüm veriler dahil olmak üzere, ürünlerdeki tüm verileri seçin.
SELECT *
FROM products
INNER JOIN manufacturers ON products.code= manufacturers.code;

-- 1.11 Tüm ürünlerin ürün adını, fiyatını ve üretici adını seçin.
select products.name, products.price,manufacturers.name from products inner manufacturers ON products.code= manufacturers.code;

SELECT products.name AS product_name, price, manufacturers.name AS manufacturer_name
FROM products
INNER JOIN manufacturers ON products.code = manufacturers.code;
-- 1.12 Her bir üreticinin ürününün ortalama fiyatını, yalnızca üretici kodunu göstererek seçin.
select round(avg(price),2),manufacturer from products group by manufacturer order by manufacturer;
