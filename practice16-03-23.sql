--Practice 7:
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

select * from ogrenciler6
-- İsmi Ali Can ve id'si 123 olan kaydı siliniz.
delete from ogrenciler6 where id=123 and isim= 'Ali Can';

-- id 'si 126'dan büyük olan kayıtları silelim.
delete from ogrenciler6 where id>126;

-- id'si 123, 125 veya 126 olanları silelim.
delete from ogrenciler6 where IN(123,125,126);?????
delete from ogrenciler6 where id=123 and id=125 and id=126;

;
--DML -Data Manipulation Lang.--> DELETE KOMUTU
/*
* DELETE FROM tablo_adı;  --> Tablonun tüm içerğini siler.
- Veriyi seçerek silmek için WHERE komutu kullanılır
* DELETE FROM tablo_adı WHERE sutun_adi = veri; -->Tabloda istediğiniz veriyi siler.
*/
--İlişkili tablolarda child tablodan veri silmeden parent tablodan silemeyiz. Eğer o veriyi silmek istiyorsak
--önce child tablodan sonra parent tablodan silebiliriz.
--NOT: Child tabloda olan bir veriyi Parent tablodan silmeye çalışalırsak
--ERROR:  update or delete on table "student" violates foreign key constraint "notlar_st_no_fkey" on table "notlar"
--hatayı alırız
/*
TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin 
tamamını siler.
Ancak, seçmeli silme yapamaz.
TRUNCATE TABLE where ...... OLMAZ
TRUNCATE TABLE ogrenciler;
-- tablodaki verileri siler
*/

--Practice 7:
-- İsmi Ali Can ve id'si 123 olan kaydı siliniz.
-- id 'si 126'dan büyük olan kayıtları silelim.
-- id'si 123, 125 veya 126 olanları silelim.
--========================================================================================
--Practice 6
--IN - OR - AND CONDITION
/*
IN Condition birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari
(Condition) tek komutla yazabilme imkani verir
AND (ve): Belirtilen şartların her ikiside gerçekleşiyorsa o kayıt listelenir.
OR (veya): Belirtilen şartlardan biri gerçekleşirse, kayıt listelenir
*/
--BETWEEN CONDITION
/*
BETWEEN Condition iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla
yazabilme imkani verir. Yazdigimiz 2 sinirda araliga dahildir (INCLUSIVE)
*/
--NOT BETWEEN CONDITION
/*
NOT BETWEEN Condition iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek
komutla yazabilme imkani verir. Yazdigimiz 2 sinirda araliga harictir (EXCLUSIVE)
*/
drop table personel

CREATE table personel3
(
id char(4),
isim varchar(50),
maas int
);
insert into personel3 values('1001', 'Ali Can', 70000);
insert into personel3 values('1002', 'Veli Mert', 85000);
insert into personel3 values('1003', 'Ayşe Tan', 65000);
insert into personel3 values('1004', 'Derya Soylu', 95000);
insert into personel3 values('1005', 'Yavuz Bal', 80000);
insert into personel3 values('1006', 'Sena Beyaz', 100000);


--Practice 6
-- id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
select * from personel3 where id between '1003' and '1005';
-- D ile Y arasındaki personel bilgilerini listeleyiniz
select * from personel3 where isim between 'D' and 'Yavuz Bal';
-- D ile Y arasında olmayan personel bilgilerini listeleyiniz
select * from personel3 where isim not between 'D' and 'Y';
-- Maaşı 70000 veya ismi Sena olan personelleri listeleyiniz
select * from personel3 where maas = 70000 or isim = 'Sena Beyaz';


--Practice 8

CREATE TABLE personel1
(
id char(9),
ISIM varchar(25),
SOYISIM varchar(25),
EMAIL varchar(20),
ISE_BASLAMA_TAR date,
IS_UNVANI varchar(20),
MAAS int
);
INSERT INTO personel1 VALUES ('123456789', 'Ali','Can' ,'alican@gmail.com', '10-APR-10','isci', 5000 );
INSERT INTO personel1 VALUES ('123456788', 'Veli','Cen' ,'velicem@gmail.com', '10-JAN-12','isci',5500 );
INSERT INTO personel1 VALUES ('123456787', 'Ayse','Gul' ,'aysegul@gmail.com', '01-MAY-14','muhasebeci',4500 );
INSERT INTO personel1 VALUES ('123456789', 'Fatma','Yasa' ,'fatmayasa@gmail.com', '10-APR-09','muhendis',7500 );

select * from personel1

--a) Yukarida verilen “personel” tablosunu olusturun

--b) Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
select * from personel1 where maas<5000 or is_unvani='isci'

--c) Iscilerin tum bilgilerini listeleyin
select * from personel1 where is_unvani='isci'

--d) Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
select is_unvani,maas from personel1 where soyisim in('Can','Cen','Gul');

--e) Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
select email,ise_baslama_tar from personel1 where maas>5000;

--f) Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
select * from personel1 where maas>5000 and maas<7000;
Select * from personel1 where maas between 5001 and 6999;

--Varolan bir Table gibi Yeni Bir Table Olusturma (Sadece istedigimiz sutunlari alma)
select 

CREATE TABLE ogr_bilgi 
AS SELECT isim, email 
FROM ogrenciler1;

--Varolan bir Table gibi Yeni Bir Table Olusturma (Tamamiyla Diger Table ile Ayni)
CREATE TABLE ogr_tum_bilgi 
AS SELECT * 
FROM ogrenciler1;
--DML – Data Manupulation Language ( Insert-Update-Delete )
--INSERT INTO komutu, Postgre SQL’de tabloya bir veya birden fazla kayit eklemek icin kullanilir.
--Tum Field’lere data eklemek icin
insert into ogrenciler1 values('1234','Erol','0532154624','erol@gmail.com','06-03-2023');

--Bazi Field’lere data eklemek icin(Parcali Veri Ekleme)
insert into ogrenciler1 (isim, tel, email) values('Ayse', '0532154625', 'ayse@gmail.com');

--a) Yukarida verilen “personel” tablosunu olusturun
--b) Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
--c) Iscilerin tum bilgilerini listeleyin
--d) Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
--e) Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
--f) Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin