---------------------- B�L�M 21 - Fonksiyonlar ----------------------
--Fonksiyon olu�turma
CREATE FUNCTION STOKARTTIR(@ADET INT)
RETURNS INT
AS
BEGIN
RETURN @ADET+26
END

--Fonksiyon �a��rma/kullanma
SELECT AD,STOK,DBO.STOKARTTIR(STOK) FROM TBLURUN

--�DEV: Stoklarda her bir sto�a bir tane fonksiyon �a��r�n. Bu fonksiyon sto�un karek�k�n� alacak ve bu alm�� oldu�u karek�k de�erini de 3 ile �arpacak.
CREATE FUNCTION STOKKAREKOK(@SAYI INT)
RETURNS DECIMAL (18,2)
AS
BEGIN
RETURN (SQRT(@SAYI))*3
END

SELECT AD,STOK,DBO.STOKKAREKOK(STOK) FROM TBLURUN
-------------------------------------------------------------------
--String T�rde Fonksiyon olu�turma
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

SELECT AD, SATISFIYAT, DBO.KDV(SATISFIYAT) AS 'KDV L� HAL�' FROM TBLURUN

--Tablo Sonu�lu Fonksiyonlar
CREATE FUNCTION URUNBILGI(@URID INT)
RETURNS TABLE
AS
RETURN SELECT * FROM TBLURUN WHERE URUNID=@URID

SELECT * FROM DBO.URUNBILGI(4)

--�DEV: Stok say�s�n� girdi�imiz zaman stok say�s�n�n alt�nda olan �r�nleri getiren fonksiyonu yaz�n�z.
CREATE FUNCTION STOKALTINDAKILER(@SAYI INT)
RETURNS TABLE
AS
RETURN SELECT * FROM TBLURUN WHERE STOK<@SAYI

SELECT * FROM dbo.STOKALTINDAKILER(50)

---------------------- B�L�M 22 - Index ----------------------
--250 Bin Datal� Tablo Olu�turma
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

--Bu a�a��daki y�ntem pek sa�l�kl� de�il. Aranan de�ere ula�ana kadar bir�ok veri okuma yap�yor ve bu durumda sisteminizi a��r� fazla yoruyor.
SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT * FROM TABLO1 WHERE ID=210387

--Clustered Index �le 210 bininci Datay� Sorgulama (Yukar�daki daha fazla veri okuma yaparken, bu daha az veri okuma yap�yor)
--CLUSTERED INDEX OLU�TURMA
CREATE CLUSTERED INDEX TABLOKAYITGETIR
ON TABLO1(ID)

SELECT * FROM TABLO1 WHERE ID=210387

