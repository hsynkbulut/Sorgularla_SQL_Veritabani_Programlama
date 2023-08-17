---------- B�L�M 7: Alfabetik Fonksiyonlar ----------
--UPPER(): B�y�k harfe �evirir
--LOWER(): K���k harfe �evirir
SELECT UPPER('merhaba') as 'B�y�k Harf'
SELECT UPPER(OGRAD) as '��renci Ad�', UPPER(OGRSOYAD) as '��renci Soyad�', LOWER(OGRSEHIR) AS '�ehir' FROM TBLOGRENCILER

--�DEV: �ehri Adana ve kul�b� Bili�im olan ��rencilerin ad�n� b�y�k, soyad�n� k���k harfle getiren sorguyu yaz�n�z.
SELECT UPPER(OGRAD) AS '��renci Ad�', LOWER(OGRSOYAD) AS '��renci Soyad�'
FROM TBLOGRENCILER
WHERE OGRSEHIR = 'Adana' AND OGRKULUP = (SELECT KULUPID FROM TBLKULUPLER WHERE KULUPAD = 'Bili�im');
--NOT: Burada alt sorgu kullanarak ��rencinin kul�p ad� bilgisini TBLKULUPLER tablosundan �ektik

--SUBSTRING(S�TUN ADI, BA�LANGI� YER�, KA� KARAKTER UZUNLU�UNDA OLACA�I): Bu metot, ilgili de�erin belli uzunluktaki k�sm�n� almaya yarar.
SELECT SUBSTRING(OGRAD,1,1) + '.' + OGRSOYAD FROM TBLOGRENCILER

/*�DEV: ��rencinin ad�n�n ilk harfi, soyad�n�n tamam� ve kul�b�n�n ad�n�n ilk 3 harfini getiren sorguyu yaz�n�z. 
�rn A.Yildirim San (San burada Santran� oluyor)*/
SELECT SUBSTRING(OGRAD,1,1) + '.' + OGRSOYAD AS 'Ad� Soyad�', SUBSTRING(KULUPAD,1,3) AS 'Kul�b�'
FROM TBLOGRENCILER
INNER JOIN TBLKULUPLER
ON TBLOGRENCILER.OGRKULUP = TBLKULUPLER.KULUPID

--LEFT(): En soldan parantez i�inde belirtilen say� kadar karakter al�r (bo�luk dahil).
--RIGHT(): En sa�dan parantez i�inde belirtilen say� kadar karakter al�r (bo�luk dahil).
SELECT LEFT('MERHABA D�NYA',9), RIGHT('MERHABA �STANBUL',2)
SELECT LEFT(OGRAD,1) + '.' + OGRSOYAD AS 'Ad Soyad' FROM TBLOGRENCILER

SELECT LEFT(DERSAD,3) AS 'Ders Ad�', AVG(ORTALAMA) AS 'S�n�f�n Ortalamas�' FROM TBLNOTLAR
INNER JOIN TBLDERSLER
ON TBLDERSLER.DERSID = TBLNOTLAR.DERS
GROUP BY DERSAD

--�DEV: Ortalama de�erlerin ondal�k k�sm�n� sadece 2 basamak getir. �rn: 64.0000 yerine 64.00 olsun.
SELECT LEFT(DERSAD,3) AS 'Ders Ad�', LEFT(AVG(ORTALAMA), 5)  AS 'S�n�f�n Ortalamas�' FROM TBLNOTLAR
INNER JOIN TBLDERSLER
ON TBLDERSLER.DERSID = TBLNOTLAR.DERS
GROUP BY DERSAD

--LEN(): Karakter uzunlu�unu verir.
SELECT OGRAD, LEN(OGRAD) AS 'Karakter say�s�' FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'

SELECT OGRAD, LEN(OGRAD) AS 'Karakter say�s�', OGRKULUP FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'
AND OGRKULUP=(SELECT KULUPID FROM TBLKULUPLER WHERE KULUPAD='Bili�im')

--��renci ad� 3 yada 4 karakter olanlar� getir
SELECT * FROM TBLOGRENCILER WHERE LEN(OGRAD)=4 OR LEN(OGRAD)=3

--�DEV: Ad� ve soyad�n�n toplam� 3 ile 7 karakter aras�nda olan ��rencileri getiren sorguyu yaz�n.
--1.YOL
SELECT * FROM TBLOGRENCILER WHERE LEN(OGRAD+OGRSOYAD)=3 OR LEN(OGRAD+OGRSOYAD)=7
--2.YOL
SELECT * FROM TBLOGRENCILER WHERE LEN(OGRAD+OGRSOYAD) BETWEEN 3 AND 7

--LTRIM: Sol taraftan bo�luklar� siler. RTRIM: Sa� taraftan bo�luklar� siler.
SELECT LTRIM('       Korkma S�nmez Bu �afaklarda Y�zen Al Sancak');
SELECT RTRIM('Korkma S�nmez Bu �afaklarda Y�zen Al Sancak        ');

--REPLACE(Ana kelime/c�mle, De�i�tirilecek de�er, Yeni de�er): Yer de�i�tirme
SELECT REPLACE('Murat Y�ceda�', 'Y�ceda�', 'Y.Da�')
SELECT REPLACE('Merhaba bug�n hava so�uk', 'a', 'e')

--�DEV: �� ��E REPLACE KULLANIMI
SELECT REPLACE(REPLACE('Merhaba bug�n hava so�uk', '�', 'u'), '�', 'g');

/*
CHARINDEX(): Aranan ifadenin ka��nc� karakterde oldu�unu verir.
CHARINDEX(Aranacak de�er, Ana kelime/c�mle)
CHARINDEX(Aranacak de�er, Ana kelime/c�mle, Ba�lang�� yeri/indexi)
*/

--e harfinin ba�tan ka��nc� indexte oldu�unu bulal�m
SELECT CHARINDEX('e','SQL Derslerine Devam Ediyoruz') AS 'Ba�tan Ka��nc� �ndex'
--e harfinin 15.indexten itibaren ba�lamak ko�uluyla ka��nc� indexte oldu�unu bulal�m
SELECT CHARINDEX('e','SQL Derslerine Devam Ediyoruz',15) AS '15den Sonra Ka��nc� �ndexte'
--Her ��renci i�in a harfinin ba�tan ka��nc� indexte oldu�unu bulal�m 
SELECT CHARINDEX('a',ograd) FROM TBLOGRENCILER

--REVERSE(): �lgili ifadeyi ters �evirir.
SELECT REVERSE('Joker')
SELECT REVERSE(DERSAD) FROM TBLDERSLER

---------- B�L�M 8: Genel Tekrar ----------
--CREATE DATABASE: Database (Veritaban�) Olu�turma
CREATE DATABASE SatisVT

--New Query diye a�t���m�z sorgu ekran�nda USE diyerek hangi veritaban�nda �al��acaksak onu se�ebiliyoruz.
USE SatisVT

--CREATE TABLE: Tablo Olu�turma
CREATE TABLE TBLKATEGORI
(
KATEGORIID TINYINT IDENTITY(1,1) PRIMARY KEY,
KATEGORIAD VARCHAR(50)
)

--CHECK(): Parantez i�indeki ko�ulu sa�l�yor mu diye kontrol etmeyi sa�lar.
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

INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('B�LG�SAYAR')
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('BEYAZ E�YA')
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('K���K EV ALET�')
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('TV')

INSERT INTO TBLURUNLER(URUNAD,URUNMARKA,KATEGORI,URUNALISFIYAT,URUNSATISFIYAT,URUNSTOK) 
VALUES('BUZDOLABI','SIEMENS',2,4356,4588,10)

UPDATE TBLURUNLER SET URUNAD='SU ISITICI' WHERE URUNAD='KETTLE'
SELECT * FROM TBLURUNLER

--KATEGOR�DEK� HER �R�NDEN KA� TANE OLDU�UNU BULAN SORGU
SELECT KATEGORIAD, COUNT(*) AS 'TOPLAM �R�N' FROM TBLURUNLER INNER JOIN TBLKATEGORI
ON TBLURUNLER.KATEGORI=TBLKATEGORI.KATEGORIID GROUP BY KATEGORIAD ORDER BY COUNT(*)

--Kategori ad� Bilgisayar olan �r�nlerin sat�� fiyat�na 500 TL zam yapal�m
UPDATE TBLURUNLER SET URUNSATISFIYAT+=500 WHERE KATEGORI=(SELECT KATEGORIID FROM TBLKATEGORI WHERE KATEGORIAD='B�LG�SAYAR')

SELECT COUNT(*) AS 'KA� FARKLI �R�N', SUM(URUNSTOK) AS 'STOK SAYISI' FROM TBLURUNLER


SELECT URUNID,URUNAD,URUNMARKA,KATEGORIAD,URUNSATISFIYAT,URUNALISFIYAT,URUNSTOK,
(URUNSATISFIYAT-URUNALISFIYAT) AS 'KAR',
(URUNSATISFIYAT-URUNALISFIYAT)*URUNSTOK AS 'TOPLAM KAR'
FROM TBLURUNLER INNER JOIN TBLKATEGORI
ON TBLURUNLER.KATEGORI=TBLKATEGORI.KATEGORIID

--�DEV: Toplam kar� 1000 TL'nin alt�nda kalan �r�nlerin sat�� fiyat�na %20 zam yapan sorguyu yaz�n�z.
UPDATE TBLURUNLER SET URUNSATISFIYAT*=1.20
WHERE (URUNSATISFIYAT-URUNALISFIYAT)*URUNSTOK<1000


