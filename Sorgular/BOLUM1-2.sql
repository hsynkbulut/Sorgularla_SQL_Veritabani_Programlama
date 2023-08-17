------------VERÝ TÝPLERÝ------------
/*
• bigint: Büyük tam sayýlarda kullanýlýr.
• BINARY(): 0 ve 1'lerden oluþan 2lik sayý sisteminde kullanýlýr.
• bit: Sadece 2 tane durumu olan ifadelerde kullanýlýr (0-1, true-false, yes-no) Örn: dersi geçti mi kaldý mý?.
• char(): Karakterler için ve sabit uzunlukta olan ifadeler için kullanýlýr. Örn: TC Kimlik No, Tel no.
• decimal(,): Ondalýklý veri tipleri için kullanýlýr. Virgülden önce þu kadar sayý, virgülden sonra þu kadar 
sayý olsun diye parantez içinde belirtiriz. Örneðin decimal(18,0) demek virgülden önce 18 karakter, virgülden 
sonra ise hiç karakter olmasýn demektir.
• int: Tam sayýlarda kullanýlýr.
• nchar(): Sabit uzunluktaki karakterler için kullanýlýr. char'dan farký ise latin alfabesi dýþýndaki alfabe 
harflerinin kullanýmýný saðlamasýdýr. Örn: Korece, Arapça gibi dillerdeki farklý karakterleri tanýmasý için 
char yerine nchar kullanýlýr.
NOT: nchar, char'a göre veritabanýnda 2 kat daha fazla yer kaplar!
• text: Uzun metinler için kullanýlýr.
• time(): Tarih, zaman aralýklarý için kullanýlýr.
• smallint: Küçük tam sayýlarda kullanýlýr. -32.768 ile 32.767 arasýnda deðerler alýr.
• tinyint: Küçük tam sayýlar için kullanýlýr. 0-255 arasýnda deðerler alýr.
• uniqueidentifier: Benzersiz, rastgele karakter oluþturmak için kullanýlýr.
• varchar(n): Deðiþken uzunluklu veriler için kullanýlýr. n, karakter sayýsýný ifade eder. 
1–8000 karakter arasýnda karakter tutabilir. Karakter sayýsý daha kýsa girilirse, chardaki 
gibi boþluklarla tamamlamaz. Örn: adlar bu veri tipinde tutulabilir.
*/

-------------------------------------------------------------------------------------------------------------------------

/* DDL KOMUTLARI (TABLO) 
• CREATE
• ALTER
• DROP
*/

--CREATE: YENÝ TABLO OLUÞTURMAK ÝÇÝN
CREATE TABLE TBLDERSLER
(
DERSID tinyint,
DERSAD varchar(20)
)

/*ALTER: MEVCUT TABLODA DEÐÝÞÝKLÝK YAPMAK ÝÇÝN
Add: Ekleme yapmak için*/
Alter Table TBLDERSLER
Add KONTENJAN smallint

--Drop Column: Sütun kaldýrmak için
Alter Table TBLDERSLER
Drop Column KONTENJAN
-------------------------------------------------------------------------------
/* DML KOMUTLARI (VERÝ) 
• SELECT-->Seçme, listeleme
• INSERT-->Ekleme
• UPDATE-->Güncelleme
• DELETE-->Silme
*/

--TBLOGRENCILER tablosundaki tüm verileri listele
Select * From TBLOGRENCILER

--TBLOGRENCILER tablosundaki tüm öðrencilerin sadece ad soyad bilgilerini listele
Select OGRAD, OGRSOYAD From TBLOGRENCILER

--TBLOGRENCILER tablosundaki Adý Ali olan tüm verileri listele
Select * From TBLOGRENCILER Where OGRAD='Ali'

--TBLOGRENCILER tablosundaki Þehri Adana veya kulubü Santranç olan tüm verileri listele
Select * From TBLOGRENCILER Where OGRSEHIR='Adana' or OGRKULUP='Santranç'

--SINAVLARIN ORTALAMASINI HESAPLA
SELECT (SINAV1+SINAV2+SINAV3)/3 FROM TBLNOTLAR

--TBLOGRENCILER tablosuna sonradan yeni veri giriþi yapmak (öðrenci eklemek) için
INSERT INTO TBLOGRENCILER (OGRAD, OGRSOYAD, OGRSEHIR) VALUES ('Baran','Yücedað','Elazýð')

--TBLNOTLAR tablosuna sonradan yeni veri giriþi yapmak (öðrenci sýnav not bilgisi eklemek) için
INSERT INTO TBLNOTLAR (OGRENCI, DERS, SINAV1, SINAV3) VALUES (6,2,88,67)

--TBLDERSLER tablosundan Tarih dersini silmek
DELETE FROM TBLDERSLER WHERE DERSAD='Tarih'

--TRUNCATE: Tabloyu sýfýrlamak için kullanýlýr.
TRUNCATE TABLE TBLDERSLER

--UPDATE: güncelle, SET: olarak ayarla demek
--TBLOGRENCILER tablosundaki tüm cinsiyetleri Erkek yap.
UPDATE TBLOGRENCILER SET OGRCINSIYET='Erkek'

--TBLOGRENCILER tablosundaki belirli ID'ye sahip olanlarýn cinsiyetlerini Kýz yap.
UPDATE TBLOGRENCILER SET OGRCINSIYET='Kýz' WHERE OGRID=2 OR OGRID=4 OR OGRID=5

--TBLNOTLAR tablosundaki tüm öðrencilere 2 nolu dersi (Algoritma dersini verelim)
UPDATE TBLNOTLAR SET DERS=2

--TBLNOTLAR tablosuna yeni 3 kayýt girelim
INSERT INTO TBLNOTLAR (OGRENCI,DERS,SINAV1,SINAV2) VALUES (1,2,85,90)
INSERT INTO TBLNOTLAR (OGRENCI,DERS,SINAV1,SINAV2) VALUES (3,2,45,35)
INSERT INTO TBLNOTLAR (OGRENCI,DERS,SINAV1,SINAV2) VALUES (5,2,78,66)

--TBLNOTLAR tablosundaki tüm öðrenciler için sýnav ortalamasýný hesapla
UPDATE TBLNOTLAR SET ORTALAMA=(SINAV1+SINAV2+SINAV3)/3

--TBLNOTLAR tablosundaki tüm öðrenciler için sýnav ortalamasýna göre geçip geçmediðini belirt
UPDATE TBLNOTLAR SET DURUM=1 WHERE ORTALAMA>=50
UPDATE TBLNOTLAR SET DURUM=0 WHERE ORTALAMA<50
