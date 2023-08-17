---------- B�L�M 5: Birle�tirme ��lemleri ----------
--INNER JOIN (KES���M): Kar��la�t�r�lan iki tablo aras�nda yaln�zca bu iki tablonun kesi�imlerinde bulunan alanlar� verir.  
SELECT * FROM TBLNOTLAR
INNER JOIN TBLOGRENCILER
ON TBLOGRENCILER.OGRID = TBLNOTLAR.OGRENCI

--LEFT JOIN: Kar��la�t�r�lan iki tablo aras�nda yaln�zca 1.tabloda bulunan alanlar� (kesi�im k�mesi dahil) verir. 
SELECT * FROM TBLNOTLAR
LEFT JOIN TBLOGRENCILER
ON TBLOGRENCILER.OGRID = TBLNOTLAR.OGRENCI

--RIGHT JOIN: Kar��la�t�r�lan iki tablo aras�nda yaln�zca 2.tabloda bulunan alanlar� (kesi�im k�mesi dahil) verir. 
SELECT * FROM TBLNOTLAR
RIGHT JOIN TBLOGRENCILER
ON TBLOGRENCILER.OGRID = TBLNOTLAR.OGRENCI

--FULL JOIN (B�RLE��M): Kar��la�t�r�lan iki tabloda bulunan b�t�n alanlar� (kesi�im k�mesi dahil) verir. 
SELECT * FROM TBLNOTLAR
FULL JOIN TBLOGRENCILER
ON TBLOGRENCILER.OGRID = TBLNOTLAR.OGRENCI

--UNION: �ki farkl� tabloya ait b�t�n verileri birinci tablonun s�tun adlar�na g�re birle�tirir.
SELECT * FROM TBLKULUPLER UNION SELECT * FROM TBLDERSLER

---------- B�L�M 6: Aritmetik Fonksiyonlar ----------
UPDATE TBLNOTLAR SET SINAV2=SINAV2+10 FROM TBLNOTLAR WHERE DERS=1
SELECT * FROM TBLNOTLAR WHERE DERS=1
UPDATE TBLNOTLAR SET SINAV2=100 WHERE SINAV2>100

UPDATE TBLNOTLAR SET ORTALAMA=(SINAV1+SINAV2+SINAV3)/3 WHERE DERS=1

SELECT AVG(ORTALAMA) FROM TBLNOTLAR WHERE DERS=1

/* �DEV: S�n�f ortalamas�n�n alt�nda olan ��rencilerin "Durum2" s�tunlar�n�n yan�na "Alt�nda", 
aksi durumda �st�nde yazd�ran sorguyu haz�rlay�n.*/
--1.YOL
SELECT *,
    CASE 
        WHEN ORTALAMA < (SELECT AVG(ORTALAMA) FROM TBLNOTLAR) THEN 'Alt�nda'
        ELSE '�st�nde'
    END AS Durum2
FROM TBLNOTLAR;

--2.YOL
SELECT n.*, 'Alt�nda' AS Durum2
FROM TBLNOTLAR n
INNER JOIN (SELECT AVG(ORTALAMA) AS ORTALAMA FROM TBLNOTLAR) avg
ON n.ORTALAMA < avg.ORTALAMA
UNION
SELECT n.*, '�st�nde' AS Durum2
FROM TBLNOTLAR n
INNER JOIN (SELECT AVG(ORTALAMA) AS ORTALAMA FROM TBLNOTLAR) avg
ON n.ORTALAMA >= avg.ORTALAMA;

--3.YOL
Select *, '�st�nde' as 'DURUM2' From TBLNOTLAR Where ORTALAMA>(Select Avg(ORTALAMA) From TBLNOTLAR Where Ders IN (1,2))
Union
Select *, 'Alt�nda' as 'DURUM2' From TBLNOTLAR Where ORTALAMA<(Select Avg(ORTALAMA) From TBLNOTLAR Where Ders IN (1,2))

--ABS: MUTLAK DE�ER
SELECT ABS(-85) AS 'MUTLAK DE�ER'

--POWER: �S ALMA
SELECT POWER(2,4) AS '�S ALMA'

SELECT POWER(SINAV1,2) FROM TBLNOTLAR

--SQRT: KAREK�K ALMA
SELECT SQRT(625) AS 'KAREK�K'

--FLOOR(): EN YAKIN K���K SAYIYA YUVARLAR.
--CEILING(): EN YAKIN B�Y�K SAYIYA YUVARLAR.
SELECT FLOOR(4.86) AS 'TABAN', CEILING(4.86) AS 'TAVAN'

--TBLNOTLAR tablosundaki 1 numaral� ��rencinin Sinav1 notlar�n�n toplam�
SELECT SUM(SINAV1) FROM TBLNOTLAR WHERE OGRENCI=1

SELECT SINAV1,DERS FROM TBLNOTLAR WHERE OGRENCI=1

--1 NUMARALI ��RENC�N�N ALMI� OLDU�U DERSLER VE O DERSLERE A�T 1.SINAV NOTLARI
SELECT DERSAD, SINAV1 FROM TBLNOTLAR INNER JOIN TBLDERSLER ON TBLNOTLAR.DERS=TBLDERSLER.DERSID WHERE OGRENCI=1

--AY�E �INAR ADLI ��RENC�N�N ALMI� OLDU�U DERSLER VE O DERSLERE A�T B�T�N SINAV NOTLARI
SELECT DERSAD, SINAV1, SINAV2, SINAV3 FROM TBLNOTLAR INNER JOIN TBLDERSLER 
ON TBLNOTLAR.DERS=TBLDERSLER.DERSID WHERE OGRENCI=(SELECT OGRID FROM TBLOGRENCILER WHERE OGRAD='AY�E' AND OGRSOYAD='�INAR')
