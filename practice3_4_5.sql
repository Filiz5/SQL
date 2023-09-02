
/*
Practice2:
“ ogretmenler” isminde tablo olusturun. 
Icinde “kimlik_no”, “isim”, “brans” ve “cinsiyet” field’lari olsun.
“ogretmenler” tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
Kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
*/
CREATE TABLE ogretmenler (
kimlik_no varchar(5) PRIMARY KEY,   
isim varchar(15) ,
brans varchar(15),
cinsiyet varchar(1)
);
SELECT * FROM ogretmenler
INSERT INTO ogretmenler VALUES ('11111','Ayse Guler', 'Matematik', 'K')
INSERT INTO ogretmenler VALUES ('22222', 'Filiz' ,' Matematik')
-- 22222 id li kisinin cinsiyet bil guncelleyin
UPDATE ogretmenler 
SET cinsiyet = 'K' WHERE kimlik_no ='22222'
INSERT INTO ogretmenler (kimlik_no,cinsiyet) VALUES ('3333','K')
UPDATE ogretmenler 
SET isim = 'Alparslan',brans='sql' WHERE kimlik_no ='3333'
/*
Practice 3:
“sehirler” isimli bir Table olusturun. 
Tabloda “alan_kodu”, “isim”, “nufus” field’lari olsun. Isim field’i bos birakilamasin.
1.Yontemi kullanarak “alan_kodu” field’ini “Primary Key” yapi
*/
CREATE TABLE sehirler(
alan_kodu varchar(2) ,
isim varchar(15),
nufus int,
CONSTRAINT pka PRIMARY KEY (alan_kodu)
);
DROP TABLE sehirler
SELECT * FROM sehirler
INSERT INTO sehirler VALUES ('34','istanbul','22000000')
INSERT INTO sehirler VALUES ('35','izmir','22000000')
INSERT INTO sehirler VALUES ('32','ısparta',450000)
INSERT INTO sehirler VALUES ('26','Eskisehir')
--ilce sutunu olusturalim 
ALTER TABLE sehirler ADD ilce varchar(10)
-- ESKİSEJİR BİL GUNCELLE
UPDATE sehirler SET nufus = '1000000', ilce = 'Osmangazi' WHERE alan_kodu='26'
UPDATE sehirler SET nufus ='12000000' -- where yazilmadiği için tum degisiklik oldu
-- SİRALAMA YAPALİM
SELECT nufus,alan_kodu, isim from sehirler ORDER BY  alan_kodu DESC
-- max
SELECT max(alan_kodu) from sehirler
SELECT isim, (select max(alan_kodu) from sehirler) from sehirler -- max degeri tum sehirlere dagitti
SELECT isim, alan_kodu from sehirler ORDER BY alan_kodu DESC limit 2
/*
Practice 4:
“tedarikciler3” isimli bir tablo olusturun. 
Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun 
ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin
*/
CREATE TABLE tedarikcilerz (
    tedarikci_id int ,
    tedarikci_ismi varchar(15),
    iletisim_isim varchar(15),
CONSTRAINT tedarikcilerpk PRIMARY KEY (tedarikci_id)
) ;
DROP TABLE tedarikcilerz
create table urunlerz(
tedarikci_id int,
urun_id int,
    CONSTRAINT fkurunler FOREIGN KEY (tedarikci_id) REFERENCES tedarikcilerz(tedarikci_id)
    -- CONSTRAINT kural_adi FOREIGN KEY (bağlanan_sutun) REFERENCES bağlanacak_tablo_adi(sutun_adi)
);
drop table urunlerz
INSERT INTO tedarikcilerz VALUES('11111','AHMET','AHMET ILETSİM')
INSERT INTO tedarikcilerz VALUES('22222','AHMET')
select * from tedarikcilerz
-- DELETE FROM tablo_adı WHERE sutun_adi = veri;
DELETE FROM tedarikcilerz where iletisim_isim = 'AHMET ILETSİM'
UPDATE tedarikcilerz SET iletisim_isim = null where tedarikci_id = 11111
 
ALTER TABLE tedarikçilerz ADD soyadi varchar(15) BETWEEN tedarikci_ismi and iletisim_isim
SELECT * FROM sehirler
select isim FROM sehirler WHERE alan_kodu BETWEEN 35 AND 26
select * from urunlerz
INSERT INTO urunlerz (urun_id) VALUES (11)
INSERT INTO urunlerz (urun_id) VALUES (12)
INSERT INTO urunlerz (urun_id) VALUES (13)
select urun_id FROM urunlerz WHERE urun_id BETWEEN 11 AND 13