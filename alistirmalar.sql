-- practice 3 
DROP TABLE sehirler1

create table sehirler4
(
alan_kod char(4),
isim varchar(10) not null,
nufus varchar(10),
constraint sehirler4_pk PRIMARY KEY (alan_kod)   
);


drop table personel3;

select * from sehirler1

CREATE TABLE personel
(
id char(10),
isim varchar(50),  
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,  
maas int,
CONSTRAINT pk PRIMARY KEY (id)    
);

--foreingn key nasil yapilir?
drop table tedarikciler

CREATE TABLE tedarikciler6
(
tedarikci_id char(10),
tedarikci_ismi varchar(50),
iletisim_isim varchar(50),
CONSTRAINT tedarikci_pk PRIMARY KEY (tedarikci_id)
);

CREATE TABLE urunler
(
tedarikci_id char(10),
product_id char(10),
CONSTRAINT urunler_fk FOREIGN KEY (tedarikci_id)

REFERENCES tedarikciler3 (tedarikci_id) 
);

---practice 5
drop table calisanlar

CREATE TABLE calisanlar(
id varchar(15) PRIMARY KEY,
isim varchar(20) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10008', 'null', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmazz', 5000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');

SELECT * FROM calisanlar;

CREATE TABLE adresler(
adres_id varchar(15),
sokak varchar(50),
cadde varchar(50),
sehir varchar(50),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id));



DROP TABLE calisanlar;
DROP TABLE adresler;


select * from adresler 

INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

INSERT INTO adresler VALUES('10004','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

CREATE TABLE ogrenciler6
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);


INSERT INTO ogrenciler6 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler6 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler6 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler6 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Ali', 99);
-- varolan tablodan yeni bir tablo olusturmak
create table notlar

as select isim,yazili_notu from ogrenciler6

select * from notlar
-------------------------------


select * from ogrenciler6

DELETE FROM ogrenciler6 WHERE id = 124;
DELETE FROM ogrenciler6 WHERE isim= 'Kemal Yasa';
DELETE FROM ogrenciler6
WHERE isim = 'Nesibe Yilmaz' or isim='Mustafa Bak';
--------------------------------------------------
--ON DELETE CASCADE 
-- PARENT TABLE 
CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO talebeler VALUES(123, 'Ali
Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124,
'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125,
'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126,
'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127,
'Mustafa Bak', 'Can',99);
DROP TABLE notlar
---CHILD TABLE
CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id)
REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

DELETE from notlar where talebe_id='123';
select * from notlar
select * from talebeler 

DELETE from talebeler where id='126';
DELETE FROM talebeler

DROP TABLE talebeler CASCADE;

--- -----
--practice 2
create table ogretmenler
(
kimlik_no char(20),
isim varchar(20),
brans varchar(15),
cinsiyet char(1)
)

select * from ogretmenler
insert into ogretmenler values (567597624,'Ali Guler','matemetik','k');
insert into ogretmenler values (567593424,'Ayse Kaya');
------------
drop table personel
---practice 6 
CREATE table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000)

--id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
select * from personel where id between '1003' and '1005';

--D ile Y arasındaki personel bilgilerini listeleyiniz

select * from personel where isim between 'D%' and 'Y%'
--D ile Y arasında olmayan personel bilgilerini listeleyiniz
select * from personel where isim not between 'D%' and 'Y%'
--Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
drop table mart
drop table nisan

CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);


INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT urun_id,musteri_isim FROM mart
WHERE exists (select urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id)

----Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (SELECT urun_isim FROM mart where mart.urun_isim=nisan.urun_isim)

SELECT urun_isim,musteri_isim FROM nisan
WHERE urun_isim in (SELECT urun_isim FROM mart where mart.urun_isim=nisan.urun_isim)


--Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

select urun_isim,musteri_isim from nisan where not exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim)
-------------------------------------------------------
---UPDATE SET --- DML KOMUTU (UPDATE, INSERT INTO, DELETE)


CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
CREATE TABLE urunler -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino)
REFERENCES tedarikciler(vergi_no)
on delete cascade
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');




















































