-- SQL UYGULAMA
/*
Aşağıdaki tabloyu SQL kodlarını kullanarak oluşturunuz.
+----+-------+-----+--------+------------------+
| id | isim  | yas | maas   |  email		   | 
+----+-------+-----+--------+------------------+
| 1  | Ali   | 39  | 12500  |ali@gmail.com	   |
| 2  | Derya | 28  | 15000  |derya@yahoo.com   |
| 3  | Sevim | 24  | 25000  |sevim@hotmail.com |
| 4  | Yusuf | 32  | 18000  |yusuf@gmail.com   |
| 5  | Halil | 48  | 22000  |halil@gmail.com   |
| 6  | Ece   | 54  | 21000  |ece@gmail.com     |
| 7  | Can   | 38  | 19000  |can@gmail.com     |
| 8  | Elif  | 27  | 14000  |elif@gmail.com    |
| 9  | Ezgi  | 35  | 21000  |ezgi@gmail.com    |
+----+-------+-----+--------+------------------+
*/

CREATE TABLE PERSONEL_1
(
ID REAL,
ISIM VARCHAR(20),
YAS REAL,
MAAS REAL,
EMAIL VARCHAR(50)
);

--drop table personel_1;

insert into personel_1 (id, isim, yas, maas, email) values (1, 'Ali', 39, 12500, 'ali@gmail.com');
insert into personel_1 (id, isim, yas, maas, email) values (2, 'Derya', 28, 15000, 'derya@yahoo.com');
insert into personel_1 (id, isim, yas, maas, email) values (3, 'Sevim', 24, 25000, 'sevim@hotmail.com');
insert into personel_1 (id, isim, yas, maas, email) values (4, 'Yusuf', 32, 18000, 'yusuf@gmail.com');
insert into personel_1 (id, isim, yas, maas, email) values (5, 'Halil', 48, 22000, 'halil@gmail.com');
insert into personel_1 (id, isim, yas, maas, email) values (6, 'Ece', 54, 21000, 'ece@gmail.com');
insert into personel_1 (id, isim, yas, maas, email) values (7, 'Can', 38, 19000, 'can@gmail.com');
insert into personel_1 (id, isim, yas, maas, email) values (8, 'Elif', 27, 14000, 'elif@gmail.com');
insert into personel_1 (id, isim, yas, maas, email) values (9, 'Ezgi', 38, 21000, 'ezgi@gmail.com');
insert into personel_1 (id, isim, yas, maas, email) values (10, 'Sena', 25, 11000, NULL);



-- 1) Tablo bilgilerini listeleyiniz.
select * from personel_1;
-- 2) isim, yaş ve maaş bilgilerini listeleyiniz
select isim,yas,maas from personel_1;
-- 3) id'si 8 olan personel bilgilerini listeleyiniz
select * from personel_1 where id=8;
-- 4) id'si 5 olan personelin isim, yaş ve email bilgilerini listeleyiniz
select isim,yas,email from personel_1 where id=5;
-- 5) 30 yaşından büyük personel bilgilerini listeleyiniz.
select * from personel_1 where yas>30;
-- 6) maası 21000 olmayan personel bilgilerini listeleyiniz.
select * from personel_1 where  not maas=21000;
-- 7) ismi a harfi ile başlayan personel bilgilerini listeleyiniz.
select * from personel_1 where isim like 'A%';
-- 8) ismi n harfi ile biten personel bilgilerini listeleyiniz.
select * from personel_1 where isim like '%n';

-- 9) email adresi gmail olan personel bilgilerini listeleyiniz.
select * from personel_1 where email like '%gmail%';
-- 10) email adresi gmail olmayan personel bilgilerini listeleyiniz.
select * from personel_1 where email not like '%gmail%';
-- 11) id'si 3,5,7 ve 9 olan personel bilgilerini listeleyiniz.
select * from personel_1 where id in (3,5,7,9);
select * from personel_1 where id=3 or id=5 or id=7 or id=9;
-- 12) yaşı 39,48 ve 54 olmayan personel bilgilerini listeleyiniz.
select * from personel_1 where yas not in (39,48,54);
select * from personel_1 where not (yas=39 or yas=48 or yas=54);
-- 13) yaşı 30 ve 40 arasında olan personel bilgilerini listeleyiniz.
select * from personel_1 where yas between 30 and 40;
-- 14) yaşı 30 ve 40 arasında olmyan personel bilgilerini listeleyiniz.
select * from personel_1 where yas not between 30 and 40;
-- 15) emaili olmayan personel bilgilerini listeleyiniz.
select * from personel_1 where email is null;

-- 16) emaili olan personel bilgilerini listeleyiniz.
select * from personel_1 where email is  not null;

-- 17) personel bilgilerini yaşa göre sıralayınız.
select * from personel_1 order by yas;

-- 18) personel bilgilerini maaşa göre sıralayınız.
select * from personel_1 order by maas;

-- 19) personelin yaşlarını büyükten küçüğe doğru sıralayınız.
select * from personel_1 order by yas desc;
-- 20) personelin maaşlarını büyükten küçüğe doğru sıralayınız.
select * from personel_1 order by maas desc;
-- 21) En yüksek maaş olan ilk 3 personel bilgilerini sıralayınız
select * from personel_1 order by maas desc fetch next 3 row only;
select * from personel_1 order by maas desc limit 3;
-- 21) En yüksek maaş olan 4., 5. be 6. personelin bilgilerini sıralayınız
select * from personel_1 order by maas desc offset 3 limit 3;
-- 21) En yüksek maaş olandan sonraki ilk  3 personel bilgilerini sıralayınız
select * from personel_1 order by maas desc offset 1 limit 3;
----------------------------------------------------------------
----------------------------------------------------------------
--22) Maaşı 20000 den büyük olup, yaşı 35'den küçük olanları sıralayınız
select * from personel_1 where maas>20000 and yas<35;
select * from personel_1 where maas>20000 or yas<35; --order by yas; --arasındaki farkı görmek için yazılmıştır.

--23) Maaşı 20000 den büyük olanlar ile yaşı 35'den küçük olanları sıralayınız
select * from personel_1 where yas<35 or maas>20000;

--24) Maaşı 20000 den büyük olanlar ile yaşı 35'den küçük olanları yaşa göre sıralayınız
select * from personel_1 where maas>20000
union
select * from personel_1 where yas<35 order by yas;
----------------------------------------------------------------
----------------------------------------------------------------
--25) Personel_1 tablosuna sehir ve meslek sütunlarını ekleyiniz.
alter table  personel_1 
add sehir varchar(25), add meslek varchar(25);

--26) Personel_1 tablosuna sehir sütununu "sehir_adi" şeklinde değiştiriniz.
alter table  personel_1 
rename column sehir to sehir_adi;
--27) Personel_1 tablosunu calisan seklinde değiştiriniz.
alter table  personel_1 rename to calisan;

--28) Calisan tablosunda sehir_adi sütununu siliniz.
alter table  calisan drop column sehir_adi;

select * from calisan;
-- 29) Calisan tablosunda email ve meslek sütunlarını siliniz.
alter table  calisan 
drop column email, drop column meslek;