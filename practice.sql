--Primary Key ve Foreign Key Practice
Create table student(
st_no char(4) PRIMARY KEY,
isim varchar(10),
soyisim varchar(20),
tel varchar(11),
email varchar(20),
sehir varchar(20)    
);
SELECT * FROM student;
INSERT INTO student VALUES ('1234','Erol','Evren','053213546','erol@gmail.com','Ankara');
INSERT INTO student VALUES ('1235','Berk','Can','05322564','berk@gmail.com','Bursa');
INSERT INTO student VALUES ('1236','Rümeysa','Kaya','05325465','rümeysa@gmail.com','Izmir');
INSERT INTO student VALUES ('1237','Ahmet','Erkan','053215467','ahmet@gmail.com','Istanbul');
INSERT INTO student VALUES ('1238','Emre','Can','0532165466','emre@gmail.com','Burdur');

Create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real,
finalnotu real,
FOREIGN KEY (st_no) references student (st_no)    
);
INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1238','2. Dönem',55,75,95);
--DQL->Data Query Lang. -> WHERE koşulu
--Student tablosundan Berk isimli öğrencinin tel ve email bilgilerini listeleyiniz
SELECT * FROM student 
SELECT isim,tel,email FROM student WHERE isim='Berk';
--Öğrenci numarası 1236 olan öğrencinin tüm bilgilerini listeleyiniz
SELECT * FROM student WHERE st_no = '1236';
--Öğrenci numarası 1236 olan öğrencinin isim,tel ve email bilgilerini listeleyiniz
SELECT isim,tel,email FROM student WHERE st_no = '1236'
--Öğrenci numarası 1238 olan öğrencinin notlarını listeleyiniz
SELECT * FROM NOTLAR
WHERE st_no='1238';
--Öğrenci numarası 1234 olan öğrencinin notları
SELECT * FROM NOTLAR
WHERE st_no='1234';
--CHECK CONSTRANT-->Bir sütunu sınırlandırmak için kullanılır
--Constraint atamaları tablo oluşturulurken yapılmalı. Sonrasında ALTER table ile yapılan değişiklikler karışıklığa yol açar
Create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real check (ikincivizenotu>45),
finalnotu real check (finalnotu>45),
FOREIGN KEY (st_no) references student (st_no)    
);
INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1235','2. Dönem',55,46,50);
select * from notlar
--Notlar tablosundan 80'nin üstündeki ikinci vizenotları listelyiniz
SELECT ikincivizenotu FROM notlar WHERE ikincivizenotu > 80;
--Notlar tablosundan ilkvize notu 65'in altında olanları listeleyiniz
SELECT ilkvizenotu FROM notlar WHERE ilkvizenotu<65;
--DML -> DELETE komutu -> Tablo içindeki verileri siler
--SYNTAX
--DELETE FROM tablo_adi
--Eğer istediğimiz veriyi silmek istersek DELETE FROM tablo_adi WHERE sütun_adi=veri
DELETE FROM notlar; -- Notlar tablosundaki tüm veriler silindi
--Notlar tablosunda öğrenci numarası 1234 olan verinin tüm notlarını siliniz
DELETE FROM notlar WHERE st_no = '1234';
--Student tablosundan öğrenci numarası 1234 olan verinin tüm bilgilerini siliniz
DELETE FROM student WHERE st_no = '1234';
--İlişkili tablolarda child tablodan veri silmeden parent tablodan silemeyiz. Eğer o veriyi silmek istiyorsak
--önce child tablodan sonra parent tablodan silebiliriz.
--NOT: Child tabloda olan bir veriyi Parent tablodan silmeye çalışalırsak
--ERROR:  update or delete on table "student" violates foreign key constraint "notlar_st_no_fkey" on table "notlar"
--hatayı alırız
DELETE FROM student WHERE st_no = '1235';
SELECT * FROM student 
select * from notlar
--TRUNCATE -> Bu komut ile tablodaki tüm verileri silebiliriz.Yanliz şartlı silme yapamayız
TRUNCATE TABLE notlar;
-- ON DELETE CASCADE -->Bu komut sayesinde parent tablodan istediğimiz veriyi silebiliriz.
--Parent tablodan sildiğimiz zaman child tablodan da silinir
Create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real check (ikincivizenotu>45),
finalnotu real check (finalnotu>45),
FOREIGN KEY (st_no) references student (st_no) ON DELETE CASCADE    
);
INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1235','2. Dönem',55,46,50);
select * from notlar;
--Student tablosundan 1234 öğrenci numaralı öğrencinin tüm verilerini siliniz
DELETE FROM student WHERE st_no = '1234' 
/*
    ON DELETE CASCADE komutu kullanmadan parent tabloyu tamamen kaldırmak istersek,
önce child table'ı kaldırmamız gerekir.
    ON DELETE CASCADE komutunu child table oluştururken kullandıysak
-*- DROP TABLE parent_tablo_ismi CASCADE -*- yazarak kaldırabiliriz    
*/
DROP TABLE tablo_adi --> tabloyu tamamen database kaldırma komutu
DROP TABLE student CASCADE;
select * from student
-- IN CONDITION
CREATE TABLE musteriler(
urun_id int,  
musteri_isim varchar(50),  
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple');  
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');  
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');  
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');  
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');  
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

select * from musteriler
--AND ->Her iki şartı birden sağlaması gerekir
--OR -> Tek bir şartı sağlasa yeterlidir
--Ürün ismi orange ile Apple olan müşteri isimlerini listeleyiniz
SELECT musteri_isim,urun_isim FROM musteriler WHERE urun_isim='Orange' or urun_isim='Apple';
--2. YOL --> IN CONDITION KULLANIMI
SELECT musteri_isim,urun_isim FROM musteriler WHERE urun_isim IN ('Orange','Apple');
--Müsteri ismi Amy olan ile urun_ismi Palm olan verileri listeleyiniz
SELECT musteri_isim,urun_isim From musteriler WHERE musteri_isim='Mark' and urun_isim='Orange';

--NOT IN
--Ürün ismi orange ile Apple olmayan müsteri ve ürün isimlerini listeleyiniz
SELECT musteri_isim,urun_isim FROM musteriler WHERE urun_isim NOT IN ('Orange','Apple');

----BETWEEN CONDITION
--Urün id değerleri 20 ile 40 arasında olan tüm verileri listeleyiniz
SELECT * FROM musteriler WHERE urun_id>=20 and urun_id<=40;
--BETWEEN ile ;
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 and 40
--NOT BETWEEN
--Urün id değerleri 20 ile 40 arasında olmayan tüm verileri listeleyiniz
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 and 40

/*Practice 6
id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
D ile Y arasındaki personel bilgilerini listeleyiniz
D ile Y arasında olmayan personel bilgilerini listeleyiniz
Maaşı 70000 ve ismi Sena olan personeli listeleyiniz*/

drop table personel 

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
insert into personel values('1006', 'Sena Beyaz', 100000);

select * from personel;
--id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
select * from personel where id between '1003' and '1005';
--D ile Y arasındaki personel bilgilerini listeleyiniz
select * from personel where isim between 'Derya Soylu' and 'Yavuz Bal';
--D ile Y arasında olmayan personel bilgilerini listeleyiniz
select * from personel where isim not between 'Derya Soylu' and 'Yavuz Bal'
--Maaşı 70000 ve ismi Sena olan personeli listeleyiniz

select * from personel where maas = 70000 or isim = 'Sena Beyaz'

--SUBQUERY(Alt Sorgu)

CREATE TABLE calisanlar2 
(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');


CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);


SELECT isyeri, isim, maas FROM calisanlar2 WHERE isyeri IN 
(select marka_isim from markalar where calisan_sayisi>15000);

select isim,maas,sehir from calisanlar2
where isyeri in (select marka_isim from markalar where marka_id > 101);

----AGGREGATE METHOD->(sum(),count(),min(),max(),avg()->ortalama)
-- Calisanlar tablosundaki en yuksek maasi listele. 
select max(maas) as en_yuksek_maas from calisanlar2
-- en dusuk maas
select min(maas) as en_dusuk_maas from calisanlar2
---Calisanlar tablasunda kac kisi oldugunu listele
select count(isim) as kisi_sayisi from calisanlar2 -- count(*) komutu ayni sonucu verir tablodaki satirlari sayar
-- Calisanlar tablosundaki maas ortalamasini listeleyiniz.
select avg(maas) from calisanlar2
select round (avg(maas)) from calisanlar2
select round (avg(maas),2) as maas_ortalamalari from calisanlar2 -- 72.dia

-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.

select * from markalar
select marka_id,marka_isim,(select count (sehir) from calisanlar2 
where marka_isim  = isyeri) from markalar

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim,calisan_sayisi,(select sum(maas)  from calisanlar2 
where marka_isim = isyeri) as toplam_maas from markalar

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,
(SELECT max(maas) FROM calisanlar2 WHERE marka_isim=isyeri) as en_yuksek_maas,
(SELECT min(maas) FROM calisanlar2 WHERE marka_isim=isyeri) as en_dusuk_maas FROM markalar


--EXISTS CONDITION->Eğer iki tablodaki sütunlar aynı ise EXISTS CONDITION kullanılır
CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
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
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart 
select * from nisan 
/*--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
 URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
 MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.*/
 
 select urun_id,musteri_isim from mart 
 where exists (select urun_id from nisan where mart.urun_id=nisan.urun_id);
 
 /*--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.*/


select urun_isim, musteri_isim from nisan 
where exists (select urun_isim from mart where mart.urun_id=nisan.urun_id);  

--huiswerk:
--Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve  bu ürünleri
 --NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. 
 
 select urun_isim,musteri_isim from nisan where not exists (select urun_isim from mart where mart.urun_id=nisan.urun_id);  

 --DML ---> update, insert, delete
 -- syntax
 -- eger soruda bir veriyi degistiriniz gibi bir soruyla karsilasirsak once UPDATE tablo_adi
 -- set sutun_adi ()
 
 select * from personel
 
 --Personeel tablosunda id si 1001 olan ogrencinin ismini Erol Evren olarak degistiriniz.  
 update personel 
 set isim = 'Erol Evren'---> where sarti kullanmadan update islemi yaptigimizda butun sutunu set degeriyle degistiririz.
 where id = '1001';

--- HASTANE PROJESI 
CREATE TABLE hastaneler
(
id char(5) primary key, 
isim char(30),
sehir char(15),
ozel char(1)
); 
insert into hastaneler values('H101', 'Aci Madem Hastanesi', 'Istanbul', 'Y');
insert into hastaneler values('H102', 'HasZeki Hastanesi', 'Istanbul', 'N');
insert into hastaneler values('H103', 'Medikol Hastanesi', 'Izmir', 'Y');
insert into hastaneler values('H104', 'Memoryil Hastanesi', 'Ankara', 'Y');

CREATE TABLE hastalar(
  kimlik_no CHAR(11) PRIMARY Key,
  isim CHAR(50) ,
  teshis  CHAR(20)
  );
  insert INTO hastalar values('12345678901','Ali Can','Gizli Seker');
  insert INTO hastalar values('45678901121','Ayse Yilmaz','Hipertansiyon');
  insert INTO hastalar values('78901123451','Steve Jobs','Pankreatit');
  insert INTO hastalar values('12344321251','Tom Hanks','COVID 19');
   
create table bolumler(
bolum_id char(5),
bolum_adi char(20)
);
insert into bolumler values('DHL','Dahiliye');
insert into bolumler values('KBB','Kulak Burun Bogaz');
insert into bolumler values('NRJ','Noroloji');
insert into bolumler values('GAST','Gastoroloji');
insert into bolumler values('KARD','Kardioloji');
insert into bolumler values('PSK','Psikiyatri');
insert into bolumler values('GOZ','Goz Hastaliklari');

create table hasta_kayitlar(
kimlik_no char(11) Primary key,
hasta_ismi char(20),
hastane_adi char(50),
bolum_adi char(20),
teshis char(20)
);

insert into hasta_kayitlar values('1111','NO NAME','','','');
insert into hasta_kayitlar values('2222','NO NAME','','','');
insert into hasta_kayitlar values('3333','NO NAME','','','');
insert into hasta_kayitlar values('4444','NO NAME','','','');
insert into hasta_kayitlar values('5555','NO NAME','','','');

/*
hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : ‘Salvadore Dali’ ismi ile
hastane_adi: ‘John Hopins’
bolum_adi: ‘Noroloji’
teshis: ‘Parkinson’
kimlik_no: ‘99991111222’
*/
SELECT * from hasta_kayitlar;
update hasta_kayitlar set hasta_ismi = 'Salvadore Dali',
hastane_adi = 'John Hopins',
bolum_adi = 'Noroloji',
teshis = 'Parkinson',
kimlik_no = '99991111222'
where kimlik_no = '3333';


/*
hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : hastalar tablosundaki kimlik nosu ‘12345678901’ olan kişinin ismi ile
hastane_adi: hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
bolum_adi: bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
teshis: hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
kimlik_no: hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile
*/

update hasta_kayitlar

set hasta_ismi = (select isim from hastalar where kimlik_no ='12345678901'),
hastane_adi = (select isim from hastaneler where id= 'H104'),
bolum_adi = (select bolum_adi from bolumler where bolum_id ='DHL'),
teshis = (select teshis from hastalar where isim ='Ali Can'),
kimlik_no=(select kimlik_no from hastalar where isim='Ali Can')
where kimlik_no = '1111';


select * from  bolumler

UPDATE hasta_kayitlar
SET hasta_ismi=(SELECT isim FROM hastalar WHERE kimlik_no='12345678901'),
    hastane_adi=(SELECT isim FROM hastaneler WHERE id='H104'),
    bolum_adi=(SELECT bolum_adi FROM bolumler WHERE bolum_id='DHL'),
    teshis=(SELECT teshis FROM hastalar WHERE isim='Ali Can'),
    kimlik_no=(SELECT kimlik_no FROM hastalar WHERE isim='Ali Can')
    WHERE kimlik_no='1111';

--Alies
select hasta_ismi as isim from hasta_kayitlar



CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');  
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar 

-- insanlar tablasunda name degeri null olan tum verileri listeleyiniz
select * from insanlar where name is null
 -- Insanlar tablosunda name degeri null olmayan tum verileri listeleyiniz
 select * from insanlar where name is not null
 
 --Insanlar tablosunda name değeri null olan verilerin yerine 'isim girilmemis' yazdıralım
UPDATE insanlar
SET name = 'isim girilmemis'
WHERE name IS NULL

 update insanlar 
 set name='isim girilmemis' where name is null 
 
 -- Order By komute
 -- asc --> kucukden buyuge yada alfabetik olarak siralar. default olarak yazmadan kullanilir. 
 -- desc --> tersden yazdiri
  Drop table insanlar
  
 CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
 
 select * from insanlar 
 
 -- Insanlar tablosunda adres sutununu alfabetik olarak sirali sekilde tum verileri listeleyin. 
 select * from insanlar order by adres asc 
 
 -- Insanlar tablosundaki soyisim sutununu tersdenmn siralayiniz
 select * from insanlar order by soyisim desc
 
 --- Insanlar tablosunda isim ve soyisimleri isme gore normal soyisme gore tersden siralayiniz
 
  select * from insanlar order by isim asc, soyisim desc
  
--- isim ve soyisim sutunlarini soyisim kelime uzunluguna gore siralayiniz

select isim,soyisim from insanlar order by length (soyisim)asc;

-- isim ve soyisim sutunlarini birlestiriniz
select concat (isim,'  ',soyisim, ' ', adres) as isim_soyisim from insanlar order by length (isim)
  
 -- Group By Clause  
  
  
create table sirket(
isim varchar(20),    
sehir varchar(20),
maas int    
);
insert into sirket values ('erol','burdur',1000);
insert into sirket values ('erol','antalya',2000);
insert into sirket values ('erol','izmir',1500);
insert into sirket values ('ahmet','bursa',900);
insert into sirket values ('ahmet','izmir',2500);
insert into sirket values ('ahmet','istanbul',1800);
insert into sirket values ('mert','trabzon',1200);
insert into sirket values ('mert','istanbul',1000);
insert into sirket values ('mert','antep',2000);
insert into sirket values ('mert','tokat',3000);
insert into sirket values ('eda','antep',1200);
insert into sirket values ('eda','urfa',1500);
insert into sirket values ('erol','usak',2000);



insert into sirket values ('erol','burdur',900);  
  
SELECT * FROM sirket
 -- sirketde calisanlarin isinlerini listeleyin.  
select isim from sirket group by isim;
  
--Sirkette kim hangi sehirde calisiyor listele  
  select isim,sehir from sirket group by isim, sehir order by isim
  
--group by komutu aggregate methotlarla kullanimi

-- sirkette calisanlarin toplam maasini listeleyiniz

select isim,sum(maas) as toplam_maas from sirket group by isim;
  
-- sirkette calisanlarin en yuksek maas en dusuk maas larini listeleyiniz. 
select isim,max(maas) as enyuksekmaas,min(maas) as endusukmaas,round(avg(maas)) 
from sirket group by isim 
  
--tabloda kim kac ilde calisiyor 
select isim,count(sehir) as calistigi_iller from sirket group by isim order by isim
  
--- Erolun hangi sehirlerde caslistigini listeleyiniz
select isim,sehir from sirket  where isim='erol'
--toplam maasi 7000 uzerindeki kisleri listeleyiniz. 
-- Having grouplamadan sonra bir sart varsa ozaman 'having' kullanilir. sadece 'Group' komutu ile kullanilir. gruplamadan sonra where komutu kullanilmaz onun yerine 'having '
-- komutu kullanilir. 

select isim,sum(maas) as toplam_maas from sirket group by isim having sum(maas)<7000
  
-- sehirlere gore ortalama maaslari listeleyiniz



select sehir,round(avg(maas)) as ortalama_maas from sirket group by sehir  
  
 -- sehirlere gore ortalama maaslari  2000 nin altindakileri 
 --ortalama maaslarina gore buyukten kucuge listeleyinlisteleyiniz 
  
select sehir,round(avg(maas)) as ortalama_maas from sirket 
group by sehir having avg(maas) < 2000 order by ortalama_maas desc
  
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 