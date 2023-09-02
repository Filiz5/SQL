/*
YORUM İÇİN
*/
--DataBase Oluşturma
--pdAdminde kodlarımızı yazarken büyük küçük harf hassasiyeti yoktur
Create database deneme;
--DDL(Data Definition Lang.) -> Create 
Create table ogrenciler2(
ogr_no varchar(10),
isim varchar(10),
tel varchar(15),
email varchar(25),    
kayit_tarihi date    
);
--Oluşturduğumuz tablodan yeni bir tablo oluşturma
CREATE TABLE ogr_bilgi
AS SELECT isim,tel FROM ogrenciler1;
--DML -> Data Manupulation Lang. -> INSERT(Tabloya veri ekleme komutu)
--Tüm sütunlara veri ekleme
INSERT INTO ogrenciler1 VALUES ('1234','Erol','0532154624','erol@gmail.com','06-03-2023');
--Bazı sütunlara veri ekleme, Parçalı veri ekleme
INSERT INTO ogrenciler1 (isim,tel,email) values ('Evren','046498765','evren@gmail.com');
/*
Practice1:
“tedarikciler” isminde bir tablo olusturun ve “tedarikci_id”, “tedarikci_ismi”, “tedarikci_adres”
ve “ulasim_tarihi”  field’lari olsun. 
*/
CREATE TABLE tedarikciler(
tedarikci_id char(4),
tedarikci_ismi varchar(25),
tedarikci_adres varchar(50),
ulasim_tarihi date);
/*
2) Var olan tablodan yeni tablo olusturmak  
“tedarikçi_ziyaret” isminde bir tabloyu  
“tedarikciler” tablosundan olusturun.
Icinde “tedarikci_ismi”, “ulasim_tarihi” field’lari olsun.
*/
CREATE TABLE tedarikci_ziyaret                             --ALTER TABLE tedarikci_ziyaret
AS                                                         --ADD primary key (tedarikci_ismi)     
SELECT tedarikci_ismi,ulasim_tarihi FROM tedarikciler;
--DQL->Data Query Lang. -> SELECT
--Tablodaki tüm sütun bilgilerini getirmek için;
SELECT * FROM ogrenciler1;
--Tablodaki istediğimiz bir veya birden fazla sütunu getirmek için;
SELECT isim,tel FROM ogrenciler1;
--CONSTRAINT(KISITLAMA)
--UNIQUE ve NOT NULL
--NOT : Kısıtlamalar tablo oluşturulurken yapılmalıdır. Sonradan ALTER komutu ile
--kısıtlama eklenebiliri fakat bu ilişkili tablolarda sorun teşkil edebilir.
Create table ogrenciler9(
ogr_no varchar(10),
isim varchar(10) unique, --UNIQUE kısıtlamı olduğu için bir veriyi iki defa giremem
tel varchar(15) not null, -- Hem not null hem unique kısıtlaması varsa hiçlik('') bir defa kabul eder. İkinciyi etmez
email varchar(25) not null,    
kayit_tarihi date,
constraint uniq_ky UNIQUE (tel), --Eğer bir kısıtlamaya(Constrant) kendimiz isim vermek istersek örnekteki gibi kullanırız
UNIQUE (email) --Constraint ismini kendisi belirler    
);
SELECT * FROM ogrenciler8
INSERT INTO ogrenciler8 VALUES ('1234','Erol','0532154624','erol@gmail.com','06-03-2023');
INSERT INTO ogrenciler8 (isim,email) VALUES ('Evren','evren@gmail.com');
INSERT INTO ogrenciler8 VALUES ('1237','Erol5','','gazican5@gmail.com','06-03-2023');
CREATE TABLE personel
(
id char(10),
isim varchar(50) NOT NULL,  
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,  
maas int
) ;
select * from personel
INSERT INTO personel (id,soyisim) values ('12345','Evren');
/*
--ERROR:  null value in column "isim" of relation "personel" violates not-null constraint
Bu Insert islemini kabul etmez ve yukardaki gibi hata verir. Çünkü isim sütununa NOT NULL kısıtlaması
tablo oluştururken atanmıştır, dolayısıyla isim sütunu boş geçilemez.
*/
--PRIMARY KEY(UNIQUE-NOT NULL özelliği alır.Aynı zamanda ilişkili tablolar için parent tabloda pk olmalıdır)
--Tabloya Primary Key ataması 1.Yol
CREATE TABLE personel
(
id char(10) primary key,
isim varchar(50),  
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,  
maas int    
);
--Tabloya Primary Key ataması 2.Yol
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
--Tabloya Primary Key ataması 3.Yol
CREATE TABLE personel
(
id char(10),
isim varchar(50),  
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,  
maas int,
PRIMARY KEY (id)    
);
select * from personel
--FOREIGN KEY 
--> Primary key olan tablo ile bağlantı kuracak diğer tablodaki sütuna foreign key ataması yapılır
/*
Practice 4:
“tedarikciler” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,  
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/
CREATE TABLE tedarikciler3(  -->PARENT TABLE
tedarikci_id int primary key, 
tedarikci_ismi varchar(30),
iletisim_isim varchar(50)
);
CREATE TABLE urunler3( --> CHILD TABLE
tedarikci_id varchar(50),
urun_id varchar(10),
foreign key (urun_isim) references tedarikciler3(tedarikci_id)     
);
--Parent tablo'nun primary key sütunu ile child tablonun foreign key ataması yapılmış sütunu yukardaki şekilde
--bağlantı kurmuş olur
--Bağlantı kuracağımız sütunların data tipleri aynı olmalıdır
--Aynı olmazsa aşağıdaki hatayı alırız 
--Key columns "urun_isim" and "tedarikci_id" are of incompatible types: character varying and integer.