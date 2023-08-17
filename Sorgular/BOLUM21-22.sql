---------------------- BÖLÜM 21 - Fonksiyonlar ----------------------
--Fonksiyon oluþturma
CREATE FUNCTION STOKARTTIR(@ADET INT)
RETURNS INT
AS
BEGIN
RETURN @ADET+26
END

--Fonksiyon çaðýrma/kullanma
SELECT AD,STOK,DBO.STOKARTTIR(STOK) FROM TBLURUN

--ÖDEV: Stoklarda her bir stoða bir tane fonksiyon çaðýrýn. Bu fonksiyon stoðun karekökünü alacak ve bu almýþ olduðu karekök deðerini de 3 ile çarpacak.
CREATE FUNCTION STOKKAREKOK(@SAYI INT)
RETURNS DECIMAL (18,2)
AS
BEGIN
RETURN (SQRT(@SAYI))*3
END

SELECT AD,STOK,DBO.STOKKAREKOK(STOK) FROM TBLURUN
-------------------------------------------------------------------
--String Türde Fonksiyon oluþturma
CREATE FUNCTION KUCUKHARF(@ISIM VARCHAR(20))
RETURNS VARCHAR(20)
AS
BEGIN
RETURN LOWER(@ISIM)
END

SELECT DBO.KUCUKHARF(AD), STOK FROM TBLURUN

--KDV Fonksiyonu
CREATE FUNCTION KDV(@FIYAT DECIMAL(18,2))
RETURNS DECIMAL(18,2)
AS
BEGIN
RETURN @FIYAT*1.18
END

SELECT AD, SATISFIYAT, DBO.KDV(SATISFIYAT) AS 'KDV LÝ HALÝ' FROM TBLURUN

--Tablo Sonuçlu Fonksiyonlar
CREATE FUNCTION URUNBILGI(@URID INT)
RETURNS TABLE
AS
RETURN SELECT * FROM TBLURUN WHERE URUNID=@URID

SELECT * FROM DBO.URUNBILGI(4)

--ÖDEV: Stok sayýsýný girdiðimiz zaman stok sayýsýnýn altýnda olan ürünleri getiren fonksiyonu yazýnýz.
CREATE FUNCTION STOKALTINDAKILER(@SAYI INT)
RETURNS TABLE
AS
RETURN SELECT * FROM TBLURUN WHERE STOK<@SAYI

SELECT * FROM dbo.STOKALTINDAKILER(50)

---------------------- BÖLÜM 22 - Index ----------------------
--250 Bin Datalý Tablo Oluþturma
CREATE TABLE TABLO1
(
ID INT IDENTITY(1,1),
AD VARCHAR(20)
)

DECLARE @SAYAC INT=1
WHILE @SAYAC<250001
BEGIN
INSERT TABLO1
SELECT 'Kitap' + CAST(@SAYAC AS VARCHAR(20))
SET @SAYAC=@SAYAC+1
END

SELECT COUNT(*) FROM TABLO1

--Bu aþaðýdaki yöntem pek saðlýklý deðil. Aranan deðere ulaþana kadar birçok veri okuma yapýyor ve bu durumda sisteminizi aþýrý fazla yoruyor.
SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT * FROM TABLO1 WHERE ID=210387

--Clustered Index Ýle 210 bininci Datayý Sorgulama (Yukarýdaki daha fazla veri okuma yaparken, bu daha az veri okuma yapýyor)
--CLUSTERED INDEX OLUÞTURMA
CREATE CLUSTERED INDEX TABLOKAYITGETIR
ON TABLO1(ID)

SELECT * FROM TABLO1 WHERE ID=210387

