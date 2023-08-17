---------- BÖLÜM 9: Prosedürler ----------
--PROCEDURE: Aþaðýdaki örnekte olduðu gibi uzun kodlarý sürekli sürekli yazmaktansa tek bir sefer yazýp sonra bunu her yerde çaðýrýp kullanmaya yarar.
CREATE PROCEDURE HAREKETLER
AS
SELECT HAREKETID,URUNAD,MUSTERIAD + ' ' + MUSTERISOYAD AS 'AD SOYAD',
PERSONELADSOYAD,ADET,TUTAR,TARIH
FROM TBLHAREKET INNER JOIN TBLURUNLER
ON TBLHAREKET.URUN=TBLURUNLER.URUNID
INNER JOIN TBLMUSTERI
ON TBLHAREKET.MUSTERI=TBLMUSTERI.MUSTERIID
INNER JOIN TBLPERSONEL
ON TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID

--EXECUTE ProsedürAdý: Daha önce oluþturmuþ olduðumuz prosedürü çaðýrýp kullanmayý saðlar.
EXECUTE HAREKETLER

CREATE PROCEDURE DENEME
AS
SELECT * FROM TBLURUNLER WHERE URUNSTOK>10

--EXECUTE yerine EXEC yazsanýz da olur
EXEC DENEME

--Prosedür Silme
DROP PROCEDURE DENEME

--Prosedür Güncelleme
ALTER PROCEDURE HAREKETLER
AS
SELECT HAREKETID,URUNAD,LEFT(MUSTERIAD,1) + '. ' + MUSTERISOYAD AS 'AD SOYAD',
PERSONELADSOYAD,ADET,TUTAR,TARIH
FROM TBLHAREKET INNER JOIN TBLURUNLER
ON TBLHAREKET.URUN=TBLURUNLER.URUNID
INNER JOIN TBLMUSTERI
ON TBLHAREKET.MUSTERI=TBLMUSTERI.MUSTERIID
INNER JOIN TBLPERSONEL
ON TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID

--Parametreli Prosedür Kullanýmý
CREATE PROCEDURE URUNGETIR
@Deger VARCHAR(50)='BUZDOLABI'
AS
SELECT URUNAD,URUNSTOK,URUNMARKA FROM TBLURUNLER
WHERE URUNAD=@Deger

--Parametreli Prosedür'ü çaðýralým
EXEC URUNGETIR @Deger='Laptop'

--ÖDEV: Stok sayýsý kullanýcýnýn girmiþ olduðu sayýdan büyük olan ürünleri getiren prosedür yazýnýz. Stok sayýsýný dýþarýdan alýn.
CREATE PROCEDURE STOKSAYISI
@STOKADET INT
AS
SELECT * FROM TBLURUNLER WHERE URUNSTOK>@STOKADET
--------------------------------------------------------------------------------
--SORGU ÝÇÝN:
EXECUTE STOKSAYISI @STOKADET=10


---------- BÖLÜM 10: Date Sorgularý ----------
--DATEPART Sorgusu:
--Ayýn 1 ile 3.gün tarihleri arasýnda olanlarý getir.
SELECT * FROM TBLHAREKET WHERE DATEPART(DAY,TARIH) BETWEEN 1 AND 3
--Ayýn 3 ile 5 günleri arasýndaki 1 nolu müþteri kaydýný getir
SELECT * FROM TBLHAREKET WHERE DATEPART(DAY,TARIH) BETWEEN 3 AND 5 AND MUSTERI=1

--DATENAME Sorgusu:
--BU ayýn hangi ay olduðunun bilgisini ve parantez içindeki tarihin ay bilgisini getirmek için
SELECT DATENAME(MONTH,GETDATE()), DATENAME(MONTH,'2019.01.15')

--Bugün hangi gün olduðunun bilgisini getirmek için
SELECT DATENAME(WEEKDAY,GETDATE())

--Girilen tarihin gün bilgisini getirmek için
SELECT DATENAME(WEEKDAY,'2019.06.10')

--DATEDIFF Sorgusu: Tarihler arasýndaki fark bilgisini getirir
--Girilen tarih ile günümüzdeki yýlýn arasýnda kaç yýl var?
SELECT DATEDIFF(YEAR,'2010.10.25',GETDATE())

--Girilen iki tarih arasýnda kaç ay var?
SELECT DATEDIFF(MONTH,'2010.06.14','2015.08.06')

--1 nolu hareketin üzerinden kaç gün geçtiðini bulmak için
SELECT DATEDIFF(DAY,TARIH,GETDATE()) FROM TBLHAREKET WHERE HAREKETID=1

--DATEADD Sorgusu: Üzerine ekleme yapar.
--Girilen tarihin üzerine 3 yýl ekle
SELECT DATEADD(YEAR,3,'2009-10-25')
--Þuanki tarihin üzerine 45 gün ekle
SELECT DATEADD(DAY,45,GETDATE())
--Girilen tarihin üzerine 3 ay ekle
SELECT DATEADD(MONTH,3,'2009-10-25')
