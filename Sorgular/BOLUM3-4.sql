------------B�L�M 3: GRUPLANDIRMALAR VE OPERAT�RLER------------

--COUNT(): �lgili tablodaki toplam sat�r adeti/miktar� bulma.
SELECT COUNT(*) AS 'Toplam Kay�t' FROM TBLOGRENCILER
SELECT COUNT(*) AS 'Toplam Ki�i' FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'

--SUM(): �lgili s�tundaki de�erlerin toplam de�erini bulma.
SELECT SUM(SINAV1),SUM(SINAV2),SUM(SINAV3) FROM TBLNOTLAR

--AVG(): �lgili s�tundaki de�erlerin ortalamas�n� bulma.
SELECT AVG(SINAV1),AVG(SINAV2),AVG(SINAV3) FROM TBLNOTLAR

--MAX(): En y�ksek de�er, MIN(): En d���k de�er
SELECT MAX(SINAV1),MAX(SINAV2),MAX(SINAV3) FROM TBLNOTLAR
SELECT MIN(SINAV1),MIN(SINAV2),MIN(SINAV3) FROM TBLNOTLAR

--GROUP BY: Tablodaki verileri belirli bir ko�ula g�re filtreleyip grupland�rmaya yarar.
--�ehirlere g�re ��renci say�lar�n� bulmak i�in
SELECT OGRSEHIR, COUNT(*) AS 'Toplam' FROM TBLOGRENCILER GROUP BY OGRSEHIR

--Cinsiyetlere g�re ��renci say�lar�n� bulmak i�in (Toplam ��renci say�s�n�n cinsiyete g�re da��l�m�)
SELECT OGRCINSIYET, COUNT(*) AS 'Toplam' FROM TBLOGRENCILER GROUP BY OGRCINSIYET

SELECT OGRKULUP, COUNT(*) AS 'Toplam' FROM TBLOGRENCILER GROUP BY OGRKULUP

--HAVING: Sadece 2 ��rencinin bulundu�u �ehirleri getirmek i�in
SELECT OGRSEHIR, COUNT(*) AS 'SAYI' FROM TBLOGRENCILER GROUP BY OGRSEHIR HAVING COUNT(*)=2

--HAVING: ��renci kulub� Kitapl�k olan ��rencileri getirmek i�in
SELECT OGRKULUP, COUNT(*) AS 'SAYI' FROM TBLOGRENCILER GROUP BY OGRKULUP HAVING OGRKULUP='Kitapl�k'

/*LIKE: Yaln�zca i�erisinde belirli bir ifade/karakter ge�enleri getirmek i�in kullan�l�r.
LIKE '%a%' = ��erisinde 'a' ge�enleri getirir.

WHERE Soyad LIKE 'a%' = 'a' ile ba�layan t�m verileri bulur.
WHERE Soyad LIKE '%a' = 'a' ile biten t�m verileri bulur.
WHERE Soyad LIKE '%or%' = Herhangi bir konumda 'or' bulunan verileri bulur.
WHERE Soyad LIKE '_r%' = �kinci konumda 'r' bulunan t�m verileri bulur.
WHERE Soyad LIKE 'a_%' = 'a' ile ba�layan ve en az 2 karakter uzunlu�unda olan t�m verileri bulur.
WHERE Soyad LIKE 'a__%' = 'a' ile ba�layan ve en az 3 karakter uzunlu�unda olan t�m verileri bulur.
WHERE Soyad LIKE 'a%o' = 'a' ile ba�layan ve �o� ile biten t�m verileri bulur.
*/

--Ad�nda yada soyad�nda 'a' harfi ge�en t�m kay�tlar� getir
SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '%a%' OR OGRSOYAD LIKE '%a%'

--Ad� 'a' harfi ile ba�layan ve cinsiyeti 'Erkek' olan t�m kay�tlar� getir
SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE 'a%' AND OGRCINSIYET='erkek'

--NOT LIKE: Kul�p ad�nda 'a' harfi ge�meyen t�m kay�tlar� getir
SELECT * FROM TBLOGRENCILER WHERE OGRKULUP NOT LIKE '%a%'

--Ad�nda a yada b harfi olan ��rencileri getir
SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '%[A,B]%'

--Ad� a yada b harfi ile ba�layan ��rencileri getir
SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '[A,B]%'

--Kul�p ad� a'dan h'ye kadarki harflerden herhangi biri ile ba�layan ��rencileri getir
SELECT * FROM TBLOGRENCILER WHERE OGRKULUP LIKE '[a-h]%'

--DISTINCT: Her de�eri yaln�zca 1 kez g�ster, yani ayn� de�erden birden fazla olsa bile bir defa g�sterir (tekrars�z g�sterir).
--TBLOGRENCILER tablosundaki t�m �ehirleri yaln�zca bir kez g�ster
SELECT DISTINCT OGRSEHIR FROM TBLOGRENCILER

--TBLOGRENCILER tablosundaki t�m �ehirlerin toplam miktar�n� g�ster
SELECT COUNT(DISTINCT(OGRSEHIR)) AS '�EH�R SAYISI' FROM TBLOGRENCILER

/*ORDER BY: S�ralamak i�in kullan�l�r. 
ASC: A'dan Z'ye (en k���k say�dan en b�y�k say�ya) gibi hep k���kten b�y��e do�ru s�ralar.
DESC: Z'den A'ya (en b�y�k say�dan en k���k say�ya) gibi hep b�y�kten k����e do�ru s�ralar.
*/

--Adlar�na g�re ��rencileri listeleyelim
SELECT * FROM TBLOGRENCILER ORDER BY OGRAD ASC
SELECT * FROM TBLOGRENCILER ORDER BY OGRAD DESC

--TOP: En �stten �u kadar kayd� getirmek i�in. �rn: TOP 3: �stten ilk 3 kayd� getirir.
SELECT TOP 3 * FROM TBLOGRENCILER

--Sondan son 4 kayd� getirmek i�in
SELECT TOP 4 * FROM TBLOGRENCILER ORDER BY OGRID DESC

--PERCENT: En �stten kay�tlar�n %65'lik k�sm�n� getirmek i�in
SELECT TOP 65 PERCENT * FROM TBLOGRENCILER

--IN(): ��erisinde �u �u ifadelerden herhangi biri ge�iyor mu diye kontrol etmek i�in kullan�l�r. 
--UZUN YOL: SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR='�zmir' OR OGRSEHIR='Ankara' OR OGRSEHIR='Adana'
--KISA YOL:
SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR IN('�zmir','Ankara','Adana')

--NOT IN(): ��erisinde �u �u ifadelerden herhangi biri ge�medi�ini kontrol etmek i�in kullan�l�r.
SELECT * FROM TBLNOTLAR WHERE SINAV1 NOT IN(70,75,80,85,90)

--BETWEEN: Belirli bir aral�k i�erisinde olan de�erleri getirmek i�in kullan�l�r.
SELECT * FROM TBLNOTLAR WHERE ORTALAMA BETWEEN 75 AND 100

--��renci ad� A ile O aras�nda olan harfler ile ba�layan t�m kay�tlar� getir.
SELECT * FROM TBLOGRENCILER WHERE OGRAD BETWEEN 'A' AND 'O'

--NOT BETWEEN: ��renci ad� A ile O aras�nda olan harfler ile ba�layanlar�n d���nda kalan t�m kay�tlar� getir.
SELECT * FROM TBLOGRENCILER WHERE OGRAD NOT BETWEEN 'A' AND 'O'

---------------B�L�M 4: �L��K�L� TABLOLAR VE ALT SORGULAR---------------
/*�L��K�L� TABLOLAR
� Veri karma�as�n� �nler.
� Veri tekrar�n� �nler.
� Bellek performans� sa�lar.
T�RLER
� Bire Bir ili�ki
� Bire �ok ili�ki
� �oka �ok ili�ki
*/

UPDATE TBLOGRENCILER SET OGRKULUP=1 WHERE OGRKULUP='Bili�im'
UPDATE TBLOGRENCILER SET OGRKULUP=2 WHERE OGRKULUP='Kitapl�k'
UPDATE TBLOGRENCILER SET OGRKULUP=3 WHERE OGRKULUP='Santran�'
UPDATE TBLOGRENCILER SET OGRKULUP=4 WHERE OGRKULUP='Gezi'

INSERT INTO TBLOGRENCILER (OGRAD,OGRKULUP,OGRSEHIR) VALUES ('Berna',4,'Ankara')

--INNER JOIN: �ki farkl� tablodaki ortak de�erler �zerlerinden bu iki tabloyu birle�tirmeyi sa�lar.
SELECT NOTID, DERSAD FROM TBLNOTLAR 
INNER JOIN TBLDERSLER 
ON TBLNOTLAR.DERS=TBLDERSLER.DERSID
/*Yukar�daki �rnekte TBLNOTLAR tablosunda DERSAD olmad��� i�in bu bilgiyi TBLDERSLER 
tablosundan �ektik. Bunu INNER JOIN sayesinde iki tabloyu birle�tirerek yapt�k.*/

--3 farkl� tabloyu foreign key ili�kilerinden yararlanarak birle�tirip kullanma
SELECT NOTID, OGRAD + ' ' + OGRSOYAD AS 'AD SOYAD', DERSAD, SINAV1, SINAV2, SINAV3, ORTALAMA, DURUM 
FROM TBLNOTLAR 
INNER JOIN TBLDERSLER 
ON TBLNOTLAR.DERS=TBLDERSLER.DERSID
INNER JOIN TBLOGRENCILER
ON TBLNOTLAR.OGRENCI=TBLOGRENCILER.OGRID

UPDATE TBLNOTLAR SET ORTALAMA =(SINAV1+SINAV2+SINAV3)/3 WHERE DERS=1
UPDATE TBLNOTLAR SET DURUM=1 WHERE ORTALAMA>=50
UPDATE TBLNOTLAR SET DURUM=0 WHERE ORTALAMA<50

--TBLDERSLER tablosunda Matematik dersine ait olan s�nav not bilgilerini getirmek
--SUB QUERY (ALT SORGU)
SELECT * FROM TBLNOTLAR WHERE DERS=(SELECT DERSID FROM TBLDERSLER WHERE DERSAD='MATEMAT�K')

