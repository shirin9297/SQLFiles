--Personel isminde bir tablo oluşturalım
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
--Varolan personel tablosundan pers_id,sehir,adres fieldlarına sahip personel_adres adında yeni tablo olusturalım
create table personel_adres
as
select pers_id, sehir, adres from personel;
select * from personel
-- DML --> Data Manupulation Lang.
-- INSERT - UPDATE - DELETE
--Tabloya veri ekleme, tablodan veri güncelleme ve silme işlemlerinde kullanılan komutlar
--INSERT
create table student
(
id varchar(4),
st_name varchar(30),
age int
);
INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);
--Tabloya parçalı veri ekleme
insert into student(st_name,age) values ('Murat Can',65);
--DQL --> Data Query Lang.
--SELECT
select * from student;
select st_name from student;
--SELECT KOMUTU WHERE KOŞULU
select * from student WHERE age>35;

--TCL - Transaction Control Lang.
--Begin - Savepoint - rollback - commit
--Transaction veritabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer
--Bu islemler ver tabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir
CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 VALUES(default, 'Ali Can','Hasan Can',75.5);
insert into ogrenciler2 VALUES(default, 'Canan Gul','Ayse Sen',90.5);
savepoint x;
insert into ogrenciler2 VALUES (default,'Kemal Can','Ahmet Can',85.5);
insert into ogrenciler2 VALUES (default,'Ahmet Şen','Ayşe Can',65.5);

ROLLBACK TO x;

select * from ogrenciler2;

commit;

--Transaction kullaniminda SERIAL data turu kullanimi tavsiye edilmez.
--savepointten sonra ekledigimiz veride sayac mantigi ile calistigi icin
--sayacta en son hangi sayida kaldiysa ordan devam eder
-- NOT : PostgreSQL de transaction kullanimi icin 'Begin' komutuyla baslariz sonrasinda tekrar yanlis bir veriyi du
--duzeltmek veya bizim icin onemli olan verilerden sonra ekleme yapabilmek icin 'SAVEPOINT savepointadi'
--kullaniriz ve bu savepointe donebilmek icin 'ROLLBACK TO savepointismi'
--komutunu kullaniriz ve rollback calistirildiginda savepoint yazdigimiz satirin ustundeki verileri tabloda bize
--verir ve son olarak Transaction'i sonlandirmak icin mutlaka 'COMMIT' kullaniriz. My SQL de
--transaction olmadanda kullanilir

--DMl - DELETE - 
--DELETE FROM tablo_adi --> Tablonun tum icerigini siler
--Veriyi secerek silmek icin WHERE kosulu kullanilir
-- DELETE FROM tablo_adi WHERE sutun_adi = veri --> Tablodaki istedigimiz veriyi siler

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler;

--Soru : id'si 124 olan ogrenciyi siliniz
DELETE FROM ogrenciler WHERE id = 124;

--Soru : ismi Kemal Yasa olan satiri siliniz
DELETE FROM ogrenciler WHERE isim = 'Kemal Yasa';

--Soru : ismi Nesibe Yilmaz veya Mustafa Bak olan kayitlari silelim
DELETE FROM ogrenciler WHERE isim = 'Nesibe Yilmaz' or isim = 'Mustafa Bak';

-- soru: ismi Ali Can ve id'si 123 olan kaydi siliniz
delete from ogrenciler WHERE isim='Ali Can' or id=123;

--Tabloda tum verileri silelim
delete from ogrenciler 

-- DELETE _ TRUNCATE --
--TRUNCATE komutu DELETE komutu gibi bit tablodaki verilerin tamamini siler.
--Ancak, secmeli silme yapmaz
select * from ogrenciler;
TRUNCATE TABLE ogrenciler 

-- DDL - Data Definition Lang.
-- CREATE - ALTER - DROP
-- ALTER TABLE--
-- ALTER TABLE tabloda ADD, TYPE, SET, RENAME VEYA DROP COLUMNS islemleri icin kullanilir

-- personel tablosunu yeniden olusturalim
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
select * from personel;
-- Personel tablosuna cinsiyet Varchar(20) ve yas int seklinde yeni sutunla ekleyiniz
alter table personel add cinsiyet varchar(20), add yas int;

--Personel tablosundan sirket field'ini siliniz
alter table personel drop column sirket;

--Personel tablosundaki sehir sutununun adini ulke olarak degistirelim
alter table personel RENAME column sehir to ulke;

-- Personel tablosunun adını isciler olarak değiştiriniz
alter table personel rename to isciler;

--DDL - DROP komutu
DROP table isciler;

--CONSTRAINT -- kisitlamalar
--Primary Key --> Bir sutunun NULL icermemesini ve sutundaki verilerin BENZERSIZ olmasini saglar (NOT NULL - UNIQUE)
-- FOREGIN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır. Böylelikle, tablolar arasında ilişki kurmuş oluruz.
-- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
-- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
-- NOT NULL kısıtlaması için CONSTRAINT ismi tanımlanmaz. Bu kısıtlama veri türünden hemen sonra yerleştirilir
-- CHECK --> Bir sutuna yerleştirilebilecek değer aralığını sınırlamak için kullanılır.

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE, -- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
maas int NOT NULL,
ise_baslama DATE
);


INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- not null
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --primary key 
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --PRIMARY KEY


select * from calisanlar

--FOREIGN KEY --
CREATE TABLE adresler(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;





