---Zoom grup calismasi 
drop table markalar
drop table calisanlar
Create table markalar(
marka_id int NOT null,
marka_isim varchar(20) NOT NULL PRIMARY KEY, 
calisan_sayisi  int
);


create table calisanlar(
id int NOT NULL,
isim varchar(20) NOT NULL,
sehir varchar(15),
maas int,
isyeri varchar(20),
CONSTRAINT isyeri_fk foreign key (isyeri) references markalar (marka_isim) 
);

INSERT INTO markalar VALUES (101, 'Vakko', 12000);
INSERT INTO markalar VALUES (102, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES (103, 'Adidas', 10000);
INSERT INTO markalar VALUES (104, 'LCW', 21000);


INSERT INTO calisanlar VALUES (201, 'Ali Seker', 'Istanbul', 25000, 'Vakko');
INSERT INTO calisanlar VALUES(202, 'Ali Seker', 'Istanbul', 15000, 'Vakko');
INSERT INTO calisanlar VALUES(203, 'Ayse Gul', 'Istanbul', 30000, 'LCW');
INSERT INTO calisanlar VALUES(204, 'Veli Yilmaz', 'Ankara', 10000, 'Vakko');
INSERT INTO calisanlar VALUES(205, 'Derya Deniz', 'Izmir', 70000, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(206, 'Veli Yilmaz', 'Ankara', 15000, 'Adidas');
INSERT INTO calisanlar VALUES(207, 'Yusuf Kale', 'Ankara', 25000, 'Pierre Cardin');

SELECT * FROM calisanlar;
SELECT isim, sehir, maas FROM calisanlar;
SELECT * FROM markalar;
SELECT isim, maas, isyeri FROM calisanlar WHERE maas >=20000;
SELECT isim, maas, sehir, isyeri FROM calisanlar WHERE (sehir='Istanbul' OR sehir='Ankara');
/* IN kullanımı*/
SELECT isim, maas, sehir, isyeri FROM calisanlar WHERE sehir IN ('Istanbul', 'Ankara');


/* BETWEEN kullanımı; Maaşı [20000-50000] */ 
/* Manuel*/
SELECT isim, maas, sehir, isyeri FROM calisanlar WHERE (maas>=20000 AND maas<=50000); 

/* BETWEEN kullanımı*/ 
SELECT isim, maas, sehir, isyeri FROM calisanlar WHERE maas BETWEEN 20000 AND 50000; 

/*  15.000’den fazla çalışanı olan işyerlerinde çalışan kişilerin isim, maaş ve işyeri 
(marka_isim) bilgilerini getirin. */

select isim, maas, isyeri from calisanlar where isyeri in (select marka_isim from markalar where calisan_sayisi > 15000);

/* Ankara’da çalışanı olan markaların id ve calisan_sayisi bilgilerini getirin. */

select marka_id, calisan_sayisi, marka_isim from markalar where marka_isim in (select isyeri from calisanlar where sehir = 'Ankara')

/*marka_id’si 101’den büyük olan işyerlerinde çalışan kişilerin isim, maaş ve sehir bilgilerini getirin.*/
















