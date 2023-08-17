---------- BÖLÜM 15: T-SQL ----------
--DECLARE: Deðiþken tanýmlamak için kullanýlýr.
--SET: Deðiþkenin deðerini belirlemek için kullanýlýr
DECLARE @Sayi INT
SET @Sayi=24
SELECT @Sayi AS 'Sonuç'

DECLARE @sayi1 INT, @sayi2 INT, @toplam INT
SET @sayi1=20
SET @sayi2=30
SET @toplam=@sayi1+@sayi2
SELECT @toplam AS 'Toplam'

--ÖDEV: 3 tane sýnav notu girilen öðrencinin ortalamasýný hesaplayan T-SQL sorgusunu ondalýklý olarak yazýnýz.
DECLARE @sinav1 DECIMAL(4,2), @sinav2 DECIMAL(4,2), @sinav3 DECIMAL(4,2), @ortalama DECIMAL(5,2)
SET @sinav1=20
SET @sinav2=30
SET @sinav3=30
SET @ortalama=(@sinav1+@sinav2+@sinav3)/3
SELECT @ortalama AS 'Ortalama'

--3 basamaklý bir sayýnýn her basamaðýnýn deðerini ve bu basamaklarýnýn toplam deðerini veren T-SQL sorgusu
DECLARE @sayi INT, @birler INT, @onlar INT, @yuzler INT, @toplam INT
SET @sayi=456
SET @birler=@sayi % 10
SET @onlar=(@sayi / 10) % 10
SET @yuzler=@sayi / 100
SET @toplam=@birler + @onlar + @yuzler
SELECT @birler, @onlar, @yuzler, @toplam

--use: SatisVT tablosuna geçiþ yapalým
use SatisVT
SELECT * FROM TBLMUSTERI

--Müþteri bakiyesi en fazla olan kaydý getirmek
DECLARE @Bakiye INT
SET @Bakiye=(SELECT MAX(MUSTERIBAKIYE) FROM TBLMUSTERI)
SELECT @Bakiye

--Ürün stok sayýsý, maksimum ürün sayýsýna eþit olan kayýtlarý getirmek
DECLARE @stok INT
SELECT @stok=MAX(urunstok) FROM TBLURUNLER
SELECT * FROM TBLURUNLER WHERE URUNSTOK=@stok

--Sistem Fonksiyonlarý
SELECT @@SERVERNAME, @@ERROR, @@DEFAULT_LANGID, @@LANGUAGE, @@MAX_CONNECTIONS, @@MICROSOFTVERSION, @@IDENTITY, @@TEXTSIZE, @@VERSION

--Print Kullanýmý
DECLARE @s1 INT, @s2 INT, @sonuc INT
SET @s1=4
SET @s2=8
SET @sonuc=@s1*@s2
PRINT '4 Ýle 8 Sayýlarýnýn Çarpýmý'
PRINT '***************************'
PRINT @sonuc

--Tablo Tipi Deðiþkenler
Declare @Kisiler table
(
KisiID int identity (1,1),
KisiAd varchar(10),
KisiSehir varchar(15)
)

insert into @Kisiler (KisiAd,KisiSehir) values ('Ali','Malatya')
insert into @Kisiler (KisiAd,KisiSehir) values ('Emel','Trabzon')
Select * From @Kisiler where KisiSehir like '%r%'

--If-Else Kullanýmý
IF(1<5)
PRINT 'Merhaba'
ELSE
PRINT 'Selam'

IF(SELECT SUM(UrunStok) FROM TBLURUNLER) > 100
PRINT 'Toplam ürün sayýsý 100 den büyük'
ELSE
PRINT 'Toplam ürün sayýsý 100 den küçük'


IF(SELECT SUM(UrunStok) AS 'Toplam1' FROM TBLURUNLER) > 100
PRINT 'Toplam ürün sayýsý' + Toplam1 + '100 den büyük'
ELSE
PRINT 'Toplam ürün sayýsý 100 den küçük'

--ÖDEV
DECLARE @stok VARCHAR(20)
SET @stok=(SELECT SUM(UrunStok) FROM TBLURUNLER)
IF (@stok>100)
PRINT 'Toplam ürün sayýsý'+ ' '+ @stok +' ' + ' ve bu durumda 100 den büyük'
ELSE
PRINT 'Toplam ürün sayýsý'+ ' ' + @stok +' ' + ' ve bu durumda 100 den küçük'

--Case Kullanýmý
SELECT URUNAD, URUNMARKA, URUNDURUM=
CASE URUNDURUM
WHEN '1' THEN 'ÜRÜN VAR'
WHEN '0' THEN 'ÜRÜN YOK'
END
FROM TBLURUNLER

SELECT URUNAD, URUNMARKA, KATEGORI=
CASE KATEGORI
WHEN '1' THEN 'LAPTOP'
WHEN '2' THEN 'BEYAZ EÞYA'
WHEN '3' THEN 'KÜÇÜK EV ALETÝ'
END
FROM TBLURUNLER

--Birden fazla koþul ve þart olduðu için CASE boþ kalacak!
CREATE PROCEDURE TEST4
AS
SELECT URUNAD, URUNMARKA, URUNSTOK, URUNSTOK=
CASE 
WHEN URUNSTOK>=1 AND URUNSTOK<=5 THEN 'KRÝTÝK SEVÝYE'
WHEN URUNSTOK>=6 AND URUNSTOK<=10 THEN 'TAKVÝYE YAPILMALI'
WHEN URUNSTOK>10 THEN 'ÜRÜN STOK SAYISI YETERLÝ'
END
FROM TBLURUNLER

--While Döngüsü
DECLARE @sayac INT
SET @sayac=1
WHILE @sayac<=5
BEGIN
PRINT 'Merhaba SQL Dersleri'
SET @sayac=@sayac+1
END

--While döngüsü ile 1'den 10'a kadar bütün sayýlarý print ile yazdýrmak
DECLARE @i INT
SET @i=1
WHILE @i<=10
BEGIN
PRINT @i
SET @i=@i+1
END

--'1 ile 10 Arasýndaki Sayýlarýn Toplamýný WHILE döngüsü ile yapalým
DECLARE @toplam INT, @sayac INT
SET @sayac=1
SET @toplam=0
WHILE (@sayac<=10)
BEGIN
SET @toplam=@toplam+@sayac
SET @sayac+=1
END
PRINT '1 ile 10 Arasýndaki Sayýlarýn Toplamý'
PRINT '-------------------------------------'
PRINT @toplam


WHILE(SELECT AVG(URUNSATISFIYAT-URUNALISFIYAT) FROM TBLURUNLER WHERE KATEGORI=2)<=450
BEGIN
UPDATE TBLURUNLER SET URUNSATISFIYAT+=URUNSATISFIYAT*10/100
END
SELECT * FROM TBLURUNLER

--ÖDEV: Toplam ürün sayýsý 200'ü geçene kadar URUNSTOK'ta her bir ürüne birer tane ürün ekleyen sorguyu yazýnýz.
WHILE (SELECT SUM(URUNSTOK) FROM TBLURUNLER) <= 200
BEGIN
UPDATE TBLURUNLER SET URUNSTOK=(URUNSTOK + 1) WHERE URUNID IN(1,2,3,4,5,6,7,8,9,10)
END
SELECT * FROM TBLURUNLER

--WaitFor Kullanýmý
--WaitFor: Beklemek anlamýndadýr, benim sorduðum sorguyu benim istediðim zamanda çalýþtýr anlamýnda kullanýlýr.
WAITFOR DELAY '00:00:07'
SELECT * FROM TBLURUNLER

WAITFOR DELAY '00:00:05'
INSERT INTO TBLKATEGORI(KATEGORIAD) VALUES('DÝÐER')
SELECT * FROM TBLKATEGORI

