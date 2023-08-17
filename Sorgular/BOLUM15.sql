---------- B�L�M 15: T-SQL ----------
--DECLARE: De�i�ken tan�mlamak i�in kullan�l�r.
--SET: De�i�kenin de�erini belirlemek i�in kullan�l�r
DECLARE @Sayi INT
SET @Sayi=24
SELECT @Sayi AS 'Sonu�'

DECLARE @sayi1 INT, @sayi2 INT, @toplam INT
SET @sayi1=20
SET @sayi2=30
SET @toplam=@sayi1+@sayi2
SELECT @toplam AS 'Toplam'

--�DEV: 3 tane s�nav notu girilen ��rencinin ortalamas�n� hesaplayan T-SQL sorgusunu ondal�kl� olarak yaz�n�z.
DECLARE @sinav1 DECIMAL(4,2), @sinav2 DECIMAL(4,2), @sinav3 DECIMAL(4,2), @ortalama DECIMAL(5,2)
SET @sinav1=20
SET @sinav2=30
SET @sinav3=30
SET @ortalama=(@sinav1+@sinav2+@sinav3)/3
SELECT @ortalama AS 'Ortalama'

--3 basamakl� bir say�n�n her basama��n�n de�erini ve bu basamaklar�n�n toplam de�erini veren T-SQL sorgusu
DECLARE @sayi INT, @birler INT, @onlar INT, @yuzler INT, @toplam INT
SET @sayi=456
SET @birler=@sayi % 10
SET @onlar=(@sayi / 10) % 10
SET @yuzler=@sayi / 100
SET @toplam=@birler + @onlar + @yuzler
SELECT @birler, @onlar, @yuzler, @toplam

--use: SatisVT tablosuna ge�i� yapal�m
use SatisVT
SELECT * FROM TBLMUSTERI

--M��teri bakiyesi en fazla olan kayd� getirmek
DECLARE @Bakiye INT
SET @Bakiye=(SELECT MAX(MUSTERIBAKIYE) FROM TBLMUSTERI)
SELECT @Bakiye

--�r�n stok say�s�, maksimum �r�n say�s�na e�it olan kay�tlar� getirmek
DECLARE @stok INT
SELECT @stok=MAX(urunstok) FROM TBLURUNLER
SELECT * FROM TBLURUNLER WHERE URUNSTOK=@stok

--Sistem Fonksiyonlar�
SELECT @@SERVERNAME, @@ERROR, @@DEFAULT_LANGID, @@LANGUAGE, @@MAX_CONNECTIONS, @@MICROSOFTVERSION, @@IDENTITY, @@TEXTSIZE, @@VERSION

--Print Kullan�m�
DECLARE @s1 INT, @s2 INT, @sonuc INT
SET @s1=4
SET @s2=8
SET @sonuc=@s1*@s2
PRINT '4 �le 8 Say�lar�n�n �arp�m�'
PRINT '***************************'
PRINT @sonuc

--Tablo Tipi De�i�kenler
Declare @Kisiler table
(
KisiID int identity (1,1),
KisiAd varchar(10),
KisiSehir varchar(15)
)

insert into @Kisiler (KisiAd,KisiSehir) values ('Ali','Malatya')
insert into @Kisiler (KisiAd,KisiSehir) values ('Emel','Trabzon')
Select * From @Kisiler where KisiSehir like '%r%'

--If-Else Kullan�m�
IF(1<5)
PRINT 'Merhaba'
ELSE
PRINT 'Selam'

IF(SELECT SUM(UrunStok) FROM TBLURUNLER) > 100
PRINT 'Toplam �r�n say�s� 100 den b�y�k'
ELSE
PRINT 'Toplam �r�n say�s� 100 den k���k'


IF(SELECT SUM(UrunStok) AS 'Toplam1' FROM TBLURUNLER) > 100
PRINT 'Toplam �r�n say�s�' + Toplam1 + '100 den b�y�k'
ELSE
PRINT 'Toplam �r�n say�s� 100 den k���k'

--�DEV
DECLARE @stok VARCHAR(20)
SET @stok=(SELECT SUM(UrunStok) FROM TBLURUNLER)
IF (@stok>100)
PRINT 'Toplam �r�n say�s�'+ ' '+ @stok +' ' + ' ve bu durumda 100 den b�y�k'
ELSE
PRINT 'Toplam �r�n say�s�'+ ' ' + @stok +' ' + ' ve bu durumda 100 den k���k'

--Case Kullan�m�
SELECT URUNAD, URUNMARKA, URUNDURUM=
CASE URUNDURUM
WHEN '1' THEN '�R�N VAR'
WHEN '0' THEN '�R�N YOK'
END
FROM TBLURUNLER

SELECT URUNAD, URUNMARKA, KATEGORI=
CASE KATEGORI
WHEN '1' THEN 'LAPTOP'
WHEN '2' THEN 'BEYAZ E�YA'
WHEN '3' THEN 'K���K EV ALET�'
END
FROM TBLURUNLER

--Birden fazla ko�ul ve �art oldu�u i�in CASE bo� kalacak!
CREATE PROCEDURE TEST4
AS
SELECT URUNAD, URUNMARKA, URUNSTOK, URUNSTOK=
CASE 
WHEN URUNSTOK>=1 AND URUNSTOK<=5 THEN 'KR�T�K SEV�YE'
WHEN URUNSTOK>=6 AND URUNSTOK<=10 THEN 'TAKV�YE YAPILMALI'
WHEN URUNSTOK>10 THEN '�R�N STOK SAYISI YETERL�'
END
FROM TBLURUNLER

--While D�ng�s�
DECLARE @sayac INT
SET @sayac=1
WHILE @sayac<=5
BEGIN
PRINT 'Merhaba SQL Dersleri'
SET @sayac=@sayac+1
END

--While d�ng�s� ile 1'den 10'a kadar b�t�n say�lar� print ile yazd�rmak
DECLARE @i INT
SET @i=1
WHILE @i<=10
BEGIN
PRINT @i
SET @i=@i+1
END

--'1 ile 10 Aras�ndaki Say�lar�n Toplam�n� WHILE d�ng�s� ile yapal�m
DECLARE @toplam INT, @sayac INT
SET @sayac=1
SET @toplam=0
WHILE (@sayac<=10)
BEGIN
SET @toplam=@toplam+@sayac
SET @sayac+=1
END
PRINT '1 ile 10 Aras�ndaki Say�lar�n Toplam�'
PRINT '-------------------------------------'
PRINT @toplam


WHILE(SELECT AVG(URUNSATISFIYAT-URUNALISFIYAT) FROM TBLURUNLER WHERE KATEGORI=2)<=450
BEGIN
UPDATE TBLURUNLER SET URUNSATISFIYAT+=URUNSATISFIYAT*10/100
END
SELECT * FROM TBLURUNLER

--�DEV: Toplam �r�n say�s� 200'� ge�ene kadar URUNSTOK'ta her bir �r�ne birer tane �r�n ekleyen sorguyu yaz�n�z.
WHILE (SELECT SUM(URUNSTOK) FROM TBLURUNLER) <= 200
BEGIN
UPDATE TBLURUNLER SET URUNSTOK=(URUNSTOK + 1) WHERE URUNID IN(1,2,3,4,5,6,7,8,9,10)
END
SELECT * FROM TBLURUNLER

--WaitFor Kullan�m�
--WaitFor: Beklemek anlam�ndad�r, benim sordu�um sorguyu benim istedi�im zamanda �al��t�r anlam�nda kullan�l�r.
WAITFOR DELAY '00:00:07'
SELECT * FROM TBLURUNLER

WAITFOR DELAY '00:00:05'
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('D��ER')
SELECT * FROM TBLKATEGORI

