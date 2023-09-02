CREATE TABLE tedarikciler3(  -->PARENT TABLE
tedarikci_id varchar(10) primary key, 
tedarikci_ismi varchar(30),
iletisim_isim varchar(50)
);
CREATE TABLE urunler3( --> CHILD TABLE
tedarikci_id varchar(50),
urun_id varchar(10),
foreign key (tedarikci_id) references tedarikciler3(tedarikci_id)     
);