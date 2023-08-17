---------- B�L�M 9: Prosed�rler ----------
--PROCEDURE: A�a��daki �rnekte oldu�u gibi uzun kodlar� s�rekli s�rekli yazmaktansa tek bir sefer yaz�p sonra bunu her yerde �a��r�p kullanmaya yarar.
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

--EXECUTE Prosed�rAd�: Daha �nce olu�turmu� oldu�umuz prosed�r� �a��r�p kullanmay� sa�lar.
EXECUTE HAREKETLER

CREATE PROCEDURE DENEME
AS
SELECT * FROM TBLURUNLER WHERE URUNSTOK>10

--EXECUTE yerine EXEC yazsan�z da olur
EXEC DENEME

--Prosed�r Silme
DROP PROCEDURE DENEME

--Prosed�r G�ncelleme
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

--Parametreli Prosed�r Kullan�m�
CREATE PROCEDURE URUNGETIR
@Deger VARCHAR(50)='BUZDOLABI'
AS
SELECT URUNAD,URUNSTOK,URUNMARKA FROM TBLURUNLER
WHERE URUNAD=@Deger

--Parametreli Prosed�r'� �a��ral�m
EXEC URUNGETIR @Deger='Laptop'

--�DEV: Stok say�s� kullan�c�n�n girmi� oldu�u say�dan b�y�k olan �r�nleri getiren prosed�r yaz�n�z. Stok say�s�n� d��ar�dan al�n.
CREATE PROCEDURE STOKSAYISI
@STOKADET INT
AS
SELECT * FROM TBLURUNLER WHERE URUNSTOK>@STOKADET
--------------------------------------------------------------------------------
--SORGU ���N:
EXECUTE STOKSAYISI @STOKADET=10


---------- B�L�M 10: Date Sorgular� ----------
--DATEPART Sorgusu:
--Ay�n 1 ile 3.g�n tarihleri aras�nda olanlar� getir.
SELECT * FROM TBLHAREKET WHERE DATEPART(DAY,TARIH) BETWEEN 1 AND 3
--Ay�n 3 ile 5 g�nleri aras�ndaki 1 nolu m��teri kayd�n� getir
SELECT * FROM TBLHAREKET WHERE DATEPART(DAY,TARIH) BETWEEN 3 AND 5 AND MUSTERI=1

--DATENAME Sorgusu:
--BU ay�n hangi ay oldu�unun bilgisini ve parantez i�indeki tarihin ay bilgisini getirmek i�in
SELECT DATENAME(MONTH,GETDATE()), DATENAME(MONTH,'2019.01.15')

--Bug�n hangi g�n oldu�unun bilgisini getirmek i�in
SELECT DATENAME(WEEKDAY,GETDATE())

--Girilen tarihin g�n bilgisini getirmek i�in
SELECT DATENAME(WEEKDAY,'2019.06.10')

--DATEDIFF Sorgusu: Tarihler aras�ndaki fark bilgisini getirir
--Girilen tarih ile g�n�m�zdeki y�l�n aras�nda ka� y�l var?
SELECT DATEDIFF(YEAR,'2010.10.25',GETDATE())

--Girilen iki tarih aras�nda ka� ay var?
SELECT DATEDIFF(MONTH,'2010.06.14','2015.08.06')

--1 nolu hareketin �zerinden ka� g�n ge�ti�ini bulmak i�in
SELECT DATEDIFF(DAY,TARIH,GETDATE()) FROM TBLHAREKET WHERE HAREKETID=1

--DATEADD Sorgusu: �zerine ekleme yapar.
--Girilen tarihin �zerine 3 y�l ekle
SELECT DATEADD(YEAR,3,'2009-10-25')
--�uanki tarihin �zerine 45 g�n ekle
SELECT DATEADD(DAY,45,GETDATE())
--Girilen tarihin �zerine 3 ay ekle
SELECT DATEADD(MONTH,3,'2009-10-25')
