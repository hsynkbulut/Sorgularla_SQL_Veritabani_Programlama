---------- BÖLÜM 7: Alfabetik Fonksiyonlar ----------
--UPPER(): Büyük harfe çevirir
--LOWER(): Küçük harfe çevirir
SELECT UPPER('merhaba') as 'Büyük Harf'
SELECT UPPER(OGRAD) as 'Öðrenci Adý', UPPER(OGRSOYAD) as 'Öðrenci Soyadý', LOWER(OGRSEHIR) AS 'Þehir' FROM TBLOGRENCILER

--ÖDEV: Þehri Adana ve kulübü Biliþim olan öðrencilerin adýný büyük, soyadýný küçük harfle getiren sorguyu yazýnýz.
SELECT UPPER(OGRAD) AS 'Öðrenci Adý', LOWER(OGRSOYAD) AS 'Öðrenci Soyadý'
FROM TBLOGRENCILER
WHERE OGRSEHIR = 'Adana' AND OGRKULUP = (SELECT KULUPID FROM TBLKULUPLER WHERE KULUPAD = 'Biliþim');
--NOT: Burada alt sorgu kullanarak öðrencinin kulüp adý bilgisini TBLKULUPLER tablosundan çektik

--SUBSTRING(SÜTUN ADI, BAÞLANGIÇ YERÝ, KAÇ KARAKTER UZUNLUÐUNDA OLACAÐI): Bu metot, ilgili deðerin belli uzunluktaki kýsmýný almaya yarar.
SELECT SUBSTRING(OGRAD,1,1) + '.' + OGRSOYAD FROM TBLOGRENCILER

/*ÖDEV: Öðrencinin adýnýn ilk harfi, soyadýnýn tamamý ve kulübünün adýnýn ilk 3 harfini getiren sorguyu yazýnýz. 
Örn A.Yildirim San (San burada Santranç oluyor)*/
SELECT SUBSTRING(OGRAD,1,1) + '.' + OGRSOYAD AS 'Adý Soyadý', SUBSTRING(KULUPAD,1,3) AS 'Kulübü'
FROM TBLOGRENCILER
INNER JOIN TBLKULUPLER
ON TBLOGRENCILER.OGRKULUP = TBLKULUPLER.KULUPID

--LEFT(): En soldan parantez içinde belirtilen sayý kadar karakter alýr (boþluk dahil).
--RIGHT(): En saðdan parantez içinde belirtilen sayý kadar karakter alýr (boþluk dahil).
SELECT LEFT('MERHABA DÜNYA',9), RIGHT('MERHABA ÝSTANBUL',2)
SELECT LEFT(OGRAD,1) + '.' + OGRSOYAD AS 'Ad Soyad' FROM TBLOGRENCILER

SELECT LEFT(DERSAD,3) AS 'Ders Adý', AVG(ORTALAMA) AS 'Sýnýfýn Ortalamasý' FROM TBLNOTLAR
INNER JOIN TBLDERSLER
ON TBLDERSLER.DERSID = TBLNOTLAR.DERS
GROUP BY DERSAD

--ÖDEV: Ortalama deðerlerin ondalýk kýsmýný sadece 2 basamak getir. örn: 64.0000 yerine 64.00 olsun.
SELECT LEFT(DERSAD,3) AS 'Ders Adý', LEFT(AVG(ORTALAMA), 5)  AS 'Sýnýfýn Ortalamasý' FROM TBLNOTLAR
INNER JOIN TBLDERSLER
ON TBLDERSLER.DERSID = TBLNOTLAR.DERS
GROUP BY DERSAD

--LEN(): Karakter uzunluðunu verir.
SELECT OGRAD, LEN(OGRAD) AS 'Karakter sayýsý' FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'

SELECT OGRAD, LEN(OGRAD) AS 'Karakter sayýsý', OGRKULUP FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'
AND OGRKULUP=(SELECT KULUPID FROM TBLKULUPLER WHERE KULUPAD='Biliþim')

--Öðrenci adý 3 yada 4 karakter olanlarý getir
SELECT * FROM TBLOGRENCILER WHERE LEN(OGRAD)=4 OR LEN(OGRAD)=3

--ÖDEV: Adý ve soyadýnýn toplamý 3 ile 7 karakter arasýnda olan öðrencileri getiren sorguyu yazýn.
--1.YOL
SELECT * FROM TBLOGRENCILER WHERE LEN(OGRAD+OGRSOYAD)=3 OR LEN(OGRAD+OGRSOYAD)=7
--2.YOL
SELECT * FROM TBLOGRENCILER WHERE LEN(OGRAD+OGRSOYAD) BETWEEN 3 AND 7

--LTRIM: Sol taraftan boþluklarý siler. RTRIM: Sað taraftan boþluklarý siler.
SELECT LTRIM('       Korkma Sönmez Bu Þafaklarda Yüzen Al Sancak');
SELECT RTRIM('Korkma Sönmez Bu Þafaklarda Yüzen Al Sancak        ');

--REPLACE(Ana kelime/cümle, Deðiþtirilecek deðer, Yeni deðer): Yer deðiþtirme
SELECT REPLACE('Murat Yücedað', 'Yücedað', 'Y.Dað')
SELECT REPLACE('Merhaba bugün hava soðuk', 'a', 'e')

--ÖDEV: ÝÇ ÝÇE REPLACE KULLANIMI
SELECT REPLACE(REPLACE('Merhaba bugün hava soðuk', 'ü', 'u'), 'ð', 'g');

/*
CHARINDEX(): Aranan ifadenin kaçýncý karakterde olduðunu verir.
CHARINDEX(Aranacak deðer, Ana kelime/cümle)
CHARINDEX(Aranacak deðer, Ana kelime/cümle, Baþlangýç yeri/indexi)
*/

--e harfinin baþtan kaçýncý indexte olduðunu bulalým
SELECT CHARINDEX('e','SQL Derslerine Devam Ediyoruz') AS 'Baþtan Kaçýncý Ýndex'
--e harfinin 15.indexten itibaren baþlamak koþuluyla kaçýncý indexte olduðunu bulalým
SELECT CHARINDEX('e','SQL Derslerine Devam Ediyoruz',15) AS '15den Sonra Kaçýncý Ýndexte'
--Her öðrenci için a harfinin baþtan kaçýncý indexte olduðunu bulalým 
SELECT CHARINDEX('a',ograd) FROM TBLOGRENCILER

--REVERSE(): Ýlgili ifadeyi ters çevirir.
SELECT REVERSE('Joker')
SELECT REVERSE(DERSAD) FROM TBLDERSLER

---------- BÖLÜM 8: Genel Tekrar ----------
--CREATE DATABASE: Database (Veritabaný) Oluþturma
CREATE DATABASE SatisVT

--New Query diye açtýðýmýz sorgu ekranýnda USE diyerek hangi veritabanýnda çalýþacaksak onu seçebiliyoruz.
USE SatisVT

--CREATE TABLE: Tablo Oluþturma
CREATE TABLE TBLKATEGORI
(
KATEGORIID TINYINT IDENTITY(1,1) PRIMARY KEY,
KATEGORIAD VARCHAR(50)
)

--CHECK(): Parantez içindeki koþulu saðlýyor mu diye kontrol etmeyi saðlar.
CREATE TABLE TBLURUNLER
(
URUNID INT IDENTITY(1,1) PRIMARY KEY,
URUNAD VARCHAR(50),
URUNMARKA VARCHAR(50),
KATEGORI TINYINT,
URUNALISFIYAT DECIMAL(18,2),
URUNSATISFIYAT DECIMAL(18,2),
URUNSTOK SMALLINT CHECK(URUNSTOK>0),
URUNDURUM BIT DEFAULT '1'
)

CREATE TABLE TBLPERSONEL
(
PERSONELID SMALLINT IDENTITY(1,1) PRIMARY KEY,
PERSONELADSOYAD VARCHAR(50),
)

CREATE TABLE TBLMUSTERI
(
MUSTERIID INT IDENTITY(1,1) PRIMARY KEY,
MUSTERIAD VARCHAR(50),
MUSTERISOYAD VARCHAR(50),
MUSTERISEHIR VARCHAR(13),
MUSTERIBAKIYE DECIMAL(18,2)
)

CREATE TABLE TBLHAREKET
(
HAREKETID INT IDENTITY(1,1) PRIMARY KEY,
URUN INT,
MUSTERI INT,
PERSONEL SMALLINT,
ADET INT,
TUTAR DECIMAL(18,2),
TARIH SMALLDATETIME
)

INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('BÝLGÝSAYAR')
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('BEYAZ EÞYA')
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('KÜÇÜK EV ALETÝ')
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('TV')

INSERT INTO TBLURUNLER(URUNAD,URUNMARKA,KATEGORI,URUNALISFIYAT,URUNSATISFIYAT,URUNSTOK) 
VALUES('BUZDOLABI','SIEMENS',2,4356,4588,10)

UPDATE TBLURUNLER SET URUNAD='SU ISITICI' WHERE URUNAD='KETTLE'
SELECT * FROM TBLURUNLER

--KATEGORÝDEKÝ HER ÜRÜNDEN KAÇ TANE OLDUÐUNU BULAN SORGU
SELECT KATEGORIAD, COUNT(*) AS 'TOPLAM ÜRÜN' FROM TBLURUNLER INNER JOIN TBLKATEGORI
ON TBLURUNLER.KATEGORI=TBLKATEGORI.KATEGORIID GROUP BY KATEGORIAD ORDER BY COUNT(*)

--Kategori adý Bilgisayar olan ürünlerin satýþ fiyatýna 500 TL zam yapalým
UPDATE TBLURUNLER SET URUNSATISFIYAT+=500 WHERE KATEGORI=(SELECT KATEGORIID FROM TBLKATEGORI WHERE KATEGORIAD='BÝLGÝSAYAR')

SELECT COUNT(*) AS 'KAÇ FARKLI ÜRÜN', SUM(URUNSTOK) AS 'STOK SAYISI' FROM TBLURUNLER


SELECT URUNID,URUNAD,URUNMARKA,KATEGORIAD,URUNSATISFIYAT,URUNALISFIYAT,URUNSTOK,
(URUNSATISFIYAT-URUNALISFIYAT) AS 'KAR',
(URUNSATISFIYAT-URUNALISFIYAT)*URUNSTOK AS 'TOPLAM KAR'
FROM TBLURUNLER INNER JOIN TBLKATEGORI
ON TBLURUNLER.KATEGORI=TBLKATEGORI.KATEGORIID

--ÖDEV: Toplam karý 1000 TL'nin altýnda kalan ürünlerin satýþ fiyatýna %20 zam yapan sorguyu yazýnýz.
UPDATE TBLURUNLER SET URUNSATISFIYAT*=1.20
WHERE (URUNSATISFIYAT-URUNALISFIYAT)*URUNSTOK<1000


