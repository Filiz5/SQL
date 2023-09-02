--union --- kullaniminda sutun sayilari ve data tipleri ayni olmak zorunda.
drop table if exists personel--> eger tablo varsa sil yoksa bir sey yapma

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50),  
maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel 
--Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan  sehirleri    gosteren sorguyu yaziniz
Select isim as isim_sehir ,maas from personel where maas > 4000
union
select sehir,maas from personel where maas > 5000 order by isim_sehir;

---Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
--bir tabloda gosteren sorgu yaziniz

select isim as isim_sehir,maas from personel where isim = 'Mehmet Ozturk'
union
select sehir,maas from personel where sehir = 'Istanbul' order by maas;

drop table personel

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');


CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

--id’si 123456789 olan personelin Personel tablosundan sehir ve maasini, 
--personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin
select sehir as sehir_tel,maas as maas_cocuksayisi from personel where id = '123456789' 
union 
select tel,cocuk_sayisi from personel_bilgi where id ='123456789 '

--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
select isim,maas from personel where maas < 5000
union
select isim,maas from personel where maas < 5000;


select isim,maas from personel where maas < 5000
union all
select isim,maas from personel where maas < 5000;

--- INTERSECT OPERATOR 
---?????
SELECT * FROM personel

select id from personel where sehir in ('Istanbul','Ankara') --->where sehir='Istanbul or sehir='Ankara' -- da olur!
intersect 
select id from personel_bilgi where cocuk_sayisi in (2,3);

---Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin

select isim from personel where sirket ='Honda'
intersect 
select isim from personel where sirket ='Ford'
intersect 
select isim from personel where sirket ='Tofas';
--5000’den az maas alip Honda’da calismayanlari yazdirin.
select isim,sirket from personel where maas < 5000 and sirket <> 'Honda'; -- <> esit degil isareti! 

--- exceptle ile cozumu (farki demek)

select isim,sirket from personel where maas < 5000 
except 
select isim,sirket from personel where sirket = 'Honda'

--Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin isimlerini ve sehirlerini listeleyin

select isim,sehir from personel where isim = 'Mehmet Ozturk' and sehir <> 'Istanbul'
-- except le cozum--- tekrarli getirmez. except all -- kullanirsak hepsini getirir. 

select isim,sehir from personel where isim = 'Mehmet Ozturk' 
except all
select isim,sehir from personel where  sehir = 'Istanbul'

-- JOIN--- ILE ILGILI COZUMLER 

CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');  
INSERT INTO sirketler VALUES(103, 'Hyundai');


CREATE TABLE siparisler  (
siparis_id int,  
    sirket_id int,  
    siparis_tarihi date
);


INSERT INTO siparisler VALUES(11, 101, '2020-04-17');  
INSERT INTO siparisler VALUES(22, 102, '2020-04-18'); 
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');  
INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

---- INNER JOIN -- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, 
--siparis_id ve
siparis_tarihleri ile yeni bir tablo olusturun
select * from siparisler 
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler inner join siparisler on sirketler.sirket_id = siparisler.sirket_id;

--- LEFT JOIN-- eslesmiyenler tabloda NULL olarak geliyor

select * from siparisler 
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from siparisler left join sirketler on sirketler.sirket_id = siparisler.sirket_id;

-- RIGHT JOIN  

select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from siparisler right join sirketler on sirketler.sirket_id = siparisler.sirket_id;

--FULL JOIN 
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from siparisler full join sirketler on sirketler.sirket_id = siparisler.sirket_id;

--SELF JOIN

CREATE TABLE personel1  (
id int,
isim varchar(20),  
title varchar(60),  
    yonetici_id int
);

INSERT INTO personel1 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel1 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel1 VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personel1 VALUES(4, 'Fatma Can', 'CEO', 5);

--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
select * from personel1

select p1.isim as personel_isim,p2.isim as yonetici_isim 
from personel1 p1 join personel1 p2
on p1.yonetici_id = p2.id

--Like condition 
--ismi V ile baslayan personeli listeleyin.
select * from personel1 where isim like 'V%'

-- sonu N ile biten personelin tum bilgilerini listeleyiniz
select * from personel1 where isim like '%n'

-- isminin icinde 'tm' olan personelin tum bilgilerini listeleyin
select * from personel1 where isim like '%tm%'

-- '_' --> sadece bir karakteri gorterir. 
















