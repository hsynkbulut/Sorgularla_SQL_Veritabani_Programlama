------------VER� T�PLER�------------
/*
� bigint: B�y�k tam say�larda kullan�l�r.
� BINARY(): 0 ve 1'lerden olu�an 2lik say� sisteminde kullan�l�r.
� bit: Sadece 2 tane durumu olan ifadelerde kullan�l�r (0-1, true-false, yes-no) �rn: dersi ge�ti mi kald� m�?.
� char(): Karakterler i�in ve sabit uzunlukta olan ifadeler i�in kullan�l�r. �rn: TC Kimlik No, Tel no.
� decimal(,): Ondal�kl� veri tipleri i�in kullan�l�r. Virg�lden �nce �u kadar say�, virg�lden sonra �u kadar 
say� olsun diye parantez i�inde belirtiriz. �rne�in decimal(18,0) demek virg�lden �nce 18 karakter, virg�lden 
sonra ise hi� karakter olmas�n demektir.
� int: Tam say�larda kullan�l�r.
� nchar(): Sabit uzunluktaki karakterler i�in kullan�l�r. char'dan fark� ise latin alfabesi d���ndaki alfabe 
harflerinin kullan�m�n� sa�lamas�d�r. �rn: Korece, Arap�a gibi dillerdeki farkl� karakterleri tan�mas� i�in 
char yerine nchar kullan�l�r.
NOT: nchar, char'a g�re veritaban�nda 2 kat daha fazla yer kaplar!
� text: Uzun metinler i�in kullan�l�r.
� time(): Tarih, zaman aral�klar� i�in kullan�l�r.
� smallint: K���k tam say�larda kullan�l�r. -32.768 ile 32.767 aras�nda de�erler al�r.
� tinyint: K���k tam say�lar i�in kullan�l�r. 0-255 aras�nda de�erler al�r.
� uniqueidentifier: Benzersiz, rastgele karakter olu�turmak i�in kullan�l�r.
� varchar(n): De�i�ken uzunluklu veriler i�in kullan�l�r. n, karakter say�s�n� ifade eder. 
1�8000 karakter aras�nda karakter tutabilir. Karakter say�s� daha k�sa girilirse, chardaki 
gibi bo�luklarla tamamlamaz. �rn: adlar bu veri tipinde tutulabilir.
*/

-------------------------------------------------------------------------------------------------------------------------

/* DDL KOMUTLARI (TABLO) 
� CREATE
� ALTER
� DROP
*/

--CREATE: YEN� TABLO OLU�TURMAK ���N
CREATE TABLE TBLDERSLER
(
DERSID tinyint,
DERSAD varchar(20)
)

/*ALTER: MEVCUT TABLODA DE����KL�K YAPMAK ���N
Add: Ekleme yapmak i�in*/
Alter Table TBLDERSLER
Add KONTENJAN smallint

--Drop Column: S�tun kald�rmak i�in
Alter Table TBLDERSLER
Drop Column KONTENJAN
-------------------------------------------------------------------------------
/* DML KOMUTLARI (VER�) 
� SELECT-->Se�me, listeleme
� INSERT-->Ekleme
� UPDATE-->G�ncelleme
� DELETE-->Silme
*/

--TBLOGRENCILER tablosundaki t�m verileri listele
Select * From TBLOGRENCILER

--TBLOGRENCILER tablosundaki t�m ��rencilerin sadece ad soyad bilgilerini listele
Select OGRAD, OGRSOYAD From TBLOGRENCILER

--TBLOGRENCILER tablosundaki Ad� Ali olan t�m verileri listele
Select * From TBLOGRENCILER Where OGRAD='Ali'

--TBLOGRENCILER tablosundaki �ehri Adana veya kulub� Santran� olan t�m verileri listele
Select * From TBLOGRENCILER Where OGRSEHIR='Adana' or OGRKULUP='Santran�'

--SINAVLARIN ORTALAMASINI HESAPLA
SELECT (SINAV1+SINAV2+SINAV3)/3 FROM TBLNOTLAR

--TBLOGRENCILER tablosuna sonradan yeni veri giri�i yapmak (��renci eklemek) i�in
INSERT INTO TBLOGRENCILER (OGRAD, OGRSOYAD, OGRSEHIR) VALUES ('Baran','Y�ceda�','Elaz��')

--TBLNOTLAR tablosuna sonradan yeni veri giri�i yapmak (��renci s�nav not bilgisi eklemek) i�in
INSERT INTO TBLNOTLAR (OGRENCI, DERS, SINAV1, SINAV3) VALUES (6,2,88,67)

--TBLDERSLER tablosundan Tarih dersini silmek
DELETE FROM TBLDERSLER WHERE DERSAD='Tarih'

--TRUNCATE: Tabloyu s�f�rlamak i�in kullan�l�r.
TRUNCATE TABLE TBLDERSLER

--UPDATE: g�ncelle, SET: olarak ayarla demek
--TBLOGRENCILER tablosundaki t�m cinsiyetleri Erkek yap.
UPDATE TBLOGRENCILER SET OGRCINSIYET='Erkek'

--TBLOGRENCILER tablosundaki belirli ID'ye sahip olanlar�n cinsiyetlerini K�z yap.
UPDATE TBLOGRENCILER SET OGRCINSIYET='K�z' WHERE OGRID=2 OR OGRID=4 OR OGRID=5

--TBLNOTLAR tablosundaki t�m ��rencilere 2 nolu dersi (Algoritma dersini verelim)
UPDATE TBLNOTLAR SET DERS=2

--TBLNOTLAR tablosuna yeni 3 kay�t girelim
INSERT INTO TBLNOTLAR (OGRENCI,DERS,SINAV1,SINAV2) VALUES (1,2,85,90)
INSERT INTO TBLNOTLAR (OGRENCI,DERS,SINAV1,SINAV2) VALUES (3,2,45,35)
INSERT INTO TBLNOTLAR (OGRENCI,DERS,SINAV1,SINAV2) VALUES (5,2,78,66)

--TBLNOTLAR tablosundaki t�m ��renciler i�in s�nav ortalamas�n� hesapla
UPDATE TBLNOTLAR SET ORTALAMA=(SINAV1+SINAV2+SINAV3)/3

--TBLNOTLAR tablosundaki t�m ��renciler i�in s�nav ortalamas�na g�re ge�ip ge�medi�ini belirt
UPDATE TBLNOTLAR SET DURUM=1 WHERE ORTALAMA>=50
UPDATE TBLNOTLAR SET DURUM=0 WHERE ORTALAMA<50
