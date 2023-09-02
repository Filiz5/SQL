----
--LIKE CONDITION
--ismi v ile baslayan personeli listeleyiniz
SELECT * from personel1 WHERE isim LIKE 'V%'
--sonu n ile biten personelin tüm bilgilerini listeleyiniz
SELECT * from personel1 WHERE isim LIKE '%n'
--isminin içinde tm olan personelin tüm bilgilerini listeleyiniz
SELECT * from personel1 WHERE isim LIKE '%tm%'
drop table kelimeler

CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  
Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4);  
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1011, 'EROL', 4);
INSERT INTO kelimeler VALUES (1009, 'EVREN', 5);
INSERT INTO kelimeler VALUES (1010, 'ADEM', 4);

select * from kelimeler 
-- regexp like --> Altgr + u tusu ile kullanilir. bende shift + ~ isarete basinca oluyor
---SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini
--yazdiran QUERY yazin
select * from kelimeler where kelime ~ 'h[ai]t'; 

select * from kelimeler where kelime ~ 'h--a--t'; 

--SORU : Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
 
select * from kelimeler where kelime ~ '[mi]';
select * from kelimeler where kelime ~~ 'am';??

SELECT * FROM kelimeler;
--REGEXP LIKE --> AltGr+Ü tuşu ile ~ bu karakteri kullanıyoruz
--LIKE -> ~~
--SORU  : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini  yazdiran
--QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~~ 'h%';
--UPPER-LOWER-INITCAP
--Kelime sütunundaki bütün dataları büyük yazdırın
SELECT UPPER(kelime) as kelime FROM kelimeler;
--Kelimeler sütunundaki tüm dataları küçük yazdıralım
SELECT LOWER(kelime) FROM kelimeler WHERE kelime ~ '[AE]'
--Kelimer sütunundaki tüm dataların ilk harfini büyük yazalım
select initcap(kelime) as kelime from kelimeler 
----Kelimeler sütunundaki Erol ismini küçük harflerle listeleyiniz.
select lower(kelime) as kelime from kelimeler where kelime ='EROL'
--kelimeler tablosunda kelime sutunundaki tum kelimeleri kalici olarak kucuk harf yapiniz
Update kelimeler
SET kelime = lower(kelime);

update kelimeler set kelime = upper(kelime);

----DISTINCT---
CREATE TABLE musteri_urun
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (30, 'Veli', 'Elma');
INSERT INTO musteri_urun VALUES (40, 'Ayse', 'Armut');
INSERT INTO musteri_urun VALUES (50, 'Ali', 'Elma');
INSERT INTO musteri_urun VALUES (60, 'Adem', 'Portakal');
INSERT INTO musteri_urun VALUES (70, 'Veli', 'Kaysi');
INSERT INTO musteri_urun VALUES (80, 'Elif', 'Elma');

SELECT * FROM musteri_urun
---- musteri urun tablosundan musteri isimlerini tekrarsiz listeleyiniz. 
SELECT distinct (musteri_isim) FROM musteri_urun
-- Group by ile cozum;
select musteri_isim from musteri_urun 
group by musteri_isim;
--- Musteri urun tabliosundaki meyve cesitlerini listeleyiniz.

select distinct(urun_isim) from musteri_urun 

--- Musteri urun tablosunda kac cesit meyve satiliyor listeleyiniz

 select count(DISTINCT urun_isim) as urun_cesit_sayisi from musteri_urun
----FETCH NEXT (SAYI) ROW ONLY- OFFSET---

---musteri urun tablosundan son uc kaydi listeleyiniz.
--limitle cozumu
select * from musteri_urun order by urun_id desc limit 1

--FETCH NEXT ile cozumu

select * from musteri_urun order by urun_id 
desc FETCH NEXT 1 row only

---musteri urun tablosundan basdan ucuncu kaydi listeleyiniz.
select * from musteri_urun 
offset 2 limit 1
--Musteri urun tablosundan dorduncu ve altinci kaydi listeleyiniz.
--FETCH NEXT ile cozumu
select * from musteri_urun offset 3 limit 3

select * from musteri_urun where urun_id =30 or urun_id = 10
--musteri urun tablosundan 4.5.6. kaydi listeleyin

select * from musteri_urun order by urun_id 
offset 3 FETCH NEXT 3 row only

---ALTER TABLE---> TABLADAKI SUTUN VE SUTUNLARIN DATA TYPE LARI VE TABLONUN KENDISINE  MUDAHALE EDEBILMEK ICIN ALTER KOMUTU KULLANIRIZ.
--ADD
alter table tablo adi
add sutun_adi
--yeni bir sutun ekleme
select * from musteri_urun

alter table musteri_urun
add kasa_sayisi varchar(5);

alter table musteri_urun
add sehir varchar(20) default 'Ankara';
--urun_id sutununa primary key ekleyelim: constraintler genellikle tablo olusturulurken atanmali.
--constraint olmayan bir tabloya sonradan constraint eklemek iliskili tablolarda karisikliga yol acabilir. 

alter table musteri_urun 
add primary key(urun_id);-- bu atamayi urun_id sutunu unique olmadigi icin yapamaz hata verir. 
-- 2. yol
alter table musteri_urun 
add constraint pk primary key(urun_id);

delete from musteri_urun 

select * from musteri_urun

--- Eger bir sutunu yada constrainti silmek icin drop komutu kullanilir ve drop komutundan sonra 
--constraint yazip constraint ismini belirtmemiz gerekir!! 
alter table musteri_urun
drop constraint musteri_urun_pkey;
--2.yol
alter table musteri_urun
drop constraint pk;

--sehir stununu silelim
alter table musteri_urun
drop sehir 

select * from musteri_urun

--- RENAME ILE sutun ismini degistirirsin 
alter table musteri_urun
rename urun_isim to meyve

-- tablo ismini degistirmek 

Alter table musteri_urun
rename to meyveler--> tablonun ismi meyveler olarak degisti

select * from meyveler

--TYPe/set
alter table meyveler
alter kasa_sayisi type char(10)
alter meyve set not null 
-- 
---CTRL ---basili tutarak secebiliryorsun!!!!!!!!!!
--colomun type nin degistiriyoruz
alter table meyveler 
alter kasa_sayisi type int using(kasa_sayisi::int)

drop table 
--- Transaction blok 

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);

select * from ogrenciler2

delete from ogrenciler2


rollback to x;

COMMIT;

--Interview
Create table isci(
id char(2),
isim varchar(10),
maas int    
);
insert into isci values ('10','Erol',1000);
insert into isci values ('11','Evren',1500);
insert into isci values ('12','Emre',2000);
create table isci_adres(
id char(2),
sehir varchar(20),
tel varchar(15)    
);
insert into isci_adres values ('10','Burdur','0523125465');
insert into isci_adres values ('11','Ankara','0546532133');
insert into isci_adres values ('12','Bursa','0213213545');

--Personellerin isim ve sehirlerini yazdırınız
select isci.isim,isci_adres.sehir from isci full join isci_adres
on isci.id =isci_adres.id
--Ankarada çalışan personelin id ve ismini listeleyiniz

select isim,id from isci
where id in (select id from isci_adres where sehir = 'Ankara')

select * from isci













