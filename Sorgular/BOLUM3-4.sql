------------BÖLÜM 3: GRUPLANDIRMALAR VE OPERATÖRLER------------

--COUNT(): Ýlgili tablodaki toplam satýr adeti/miktarý bulma.
SELECT COUNT(*) AS 'Toplam Kayýt' FROM TBLOGRENCILER
SELECT COUNT(*) AS 'Toplam Kiþi' FROM TBLOGRENCILER WHERE OGRSEHIR='Adana'

--SUM(): Ýlgili sütundaki deðerlerin toplam deðerini bulma.
SELECT SUM(SINAV1),SUM(SINAV2),SUM(SINAV3) FROM TBLNOTLAR

--AVG(): Ýlgili sütundaki deðerlerin ortalamasýný bulma.
SELECT AVG(SINAV1),AVG(SINAV2),AVG(SINAV3) FROM TBLNOTLAR

--MAX(): En yüksek deðer, MIN(): En düþük deðer
SELECT MAX(SINAV1),MAX(SINAV2),MAX(SINAV3) FROM TBLNOTLAR
SELECT MIN(SINAV1),MIN(SINAV2),MIN(SINAV3) FROM TBLNOTLAR

--GROUP BY: Tablodaki verileri belirli bir koþula göre filtreleyip gruplandýrmaya yarar.
--Þehirlere göre öðrenci sayýlarýný bulmak için
SELECT OGRSEHIR, COUNT(*) AS 'Toplam' FROM TBLOGRENCILER GROUP BY OGRSEHIR

--Cinsiyetlere göre öðrenci sayýlarýný bulmak için (Toplam öðrenci sayýsýnýn cinsiyete göre daðýlýmý)
SELECT OGRCINSIYET, COUNT(*) AS 'Toplam' FROM TBLOGRENCILER GROUP BY OGRCINSIYET

SELECT OGRKULUP, COUNT(*) AS 'Toplam' FROM TBLOGRENCILER GROUP BY OGRKULUP

--HAVING: Sadece 2 öðrencinin bulunduðu þehirleri getirmek için
SELECT OGRSEHIR, COUNT(*) AS 'SAYI' FROM TBLOGRENCILER GROUP BY OGRSEHIR HAVING COUNT(*)=2

--HAVING: Öðrenci kulubü Kitaplýk olan öðrencileri getirmek için
SELECT OGRKULUP, COUNT(*) AS 'SAYI' FROM TBLOGRENCILER GROUP BY OGRKULUP HAVING OGRKULUP='Kitaplýk'

/*LIKE: Yalnýzca içerisinde belirli bir ifade/karakter geçenleri getirmek için kullanýlýr.
LIKE '%a%' = Ýçerisinde 'a' geçenleri getirir.

WHERE Soyad LIKE 'a%' = 'a' ile baþlayan tüm verileri bulur.
WHERE Soyad LIKE '%a' = 'a' ile biten tüm verileri bulur.
WHERE Soyad LIKE '%or%' = Herhangi bir konumda 'or' bulunan verileri bulur.
WHERE Soyad LIKE '_r%' = Ýkinci konumda 'r' bulunan tüm verileri bulur.
WHERE Soyad LIKE 'a_%' = 'a' ile baþlayan ve en az 2 karakter uzunluðunda olan tüm verileri bulur.
WHERE Soyad LIKE 'a__%' = 'a' ile baþlayan ve en az 3 karakter uzunluðunda olan tüm verileri bulur.
WHERE Soyad LIKE 'a%o' = 'a' ile baþlayan ve “o” ile biten tüm verileri bulur.
*/

--Adýnda yada soyadýnda 'a' harfi geçen tüm kayýtlarý getir
SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '%a%' OR OGRSOYAD LIKE '%a%'

--Adý 'a' harfi ile baþlayan ve cinsiyeti 'Erkek' olan tüm kayýtlarý getir
SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE 'a%' AND OGRCINSIYET='erkek'

--NOT LIKE: Kulüp adýnda 'a' harfi geçmeyen tüm kayýtlarý getir
SELECT * FROM TBLOGRENCILER WHERE OGRKULUP NOT LIKE '%a%'

--Adýnda a yada b harfi olan öðrencileri getir
SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '%[A,B]%'

--Adý a yada b harfi ile baþlayan öðrencileri getir
SELECT * FROM TBLOGRENCILER WHERE OGRAD LIKE '[A,B]%'

--Kulüp adý a'dan h'ye kadarki harflerden herhangi biri ile baþlayan öðrencileri getir
SELECT * FROM TBLOGRENCILER WHERE OGRKULUP LIKE '[a-h]%'

--DISTINCT: Her deðeri yalnýzca 1 kez göster, yani ayný deðerden birden fazla olsa bile bir defa gösterir (tekrarsýz gösterir).
--TBLOGRENCILER tablosundaki tüm þehirleri yalnýzca bir kez göster
SELECT DISTINCT OGRSEHIR FROM TBLOGRENCILER

--TBLOGRENCILER tablosundaki tüm þehirlerin toplam miktarýný göster
SELECT COUNT(DISTINCT(OGRSEHIR)) AS 'ÞEHÝR SAYISI' FROM TBLOGRENCILER

/*ORDER BY: Sýralamak için kullanýlýr. 
ASC: A'dan Z'ye (en küçük sayýdan en büyük sayýya) gibi hep küçükten büyüðe doðru sýralar.
DESC: Z'den A'ya (en büyük sayýdan en küçük sayýya) gibi hep büyükten küçüðe doðru sýralar.
*/

--Adlarýna göre öðrencileri listeleyelim
SELECT * FROM TBLOGRENCILER ORDER BY OGRAD ASC
SELECT * FROM TBLOGRENCILER ORDER BY OGRAD DESC

--TOP: En üstten þu kadar kaydý getirmek için. Örn: TOP 3: Üstten ilk 3 kaydý getirir.
SELECT TOP 3 * FROM TBLOGRENCILER

--Sondan son 4 kaydý getirmek için
SELECT TOP 4 * FROM TBLOGRENCILER ORDER BY OGRID DESC

--PERCENT: En üstten kayýtlarýn %65'lik kýsmýný getirmek için
SELECT TOP 65 PERCENT * FROM TBLOGRENCILER

--IN(): Ýçerisinde þu þu ifadelerden herhangi biri geçiyor mu diye kontrol etmek için kullanýlýr. 
--UZUN YOL: SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR='Ýzmir' OR OGRSEHIR='Ankara' OR OGRSEHIR='Adana'
--KISA YOL:
SELECT * FROM TBLOGRENCILER WHERE OGRSEHIR IN('Ýzmir','Ankara','Adana')

--NOT IN(): Ýçerisinde þu þu ifadelerden herhangi biri geçmediðini kontrol etmek için kullanýlýr.
SELECT * FROM TBLNOTLAR WHERE SINAV1 NOT IN(70,75,80,85,90)

--BETWEEN: Belirli bir aralýk içerisinde olan deðerleri getirmek için kullanýlýr.
SELECT * FROM TBLNOTLAR WHERE ORTALAMA BETWEEN 75 AND 100

--Öðrenci adý A ile O arasýnda olan harfler ile baþlayan tüm kayýtlarý getir.
SELECT * FROM TBLOGRENCILER WHERE OGRAD BETWEEN 'A' AND 'O'

--NOT BETWEEN: Öðrenci adý A ile O arasýnda olan harfler ile baþlayanlarýn dýþýnda kalan tüm kayýtlarý getir.
SELECT * FROM TBLOGRENCILER WHERE OGRAD NOT BETWEEN 'A' AND 'O'

---------------BÖLÜM 4: ÝLÝÞKÝLÝ TABLOLAR VE ALT SORGULAR---------------
/*ÝLÝÞKÝLÝ TABLOLAR
• Veri karmaþasýný önler.
• Veri tekrarýný önler.
• Bellek performansý saðlar.
TÜRLER
• Bire Bir iliþki
• Bire Çok iliþki
• Çoka Çok iliþki
*/

UPDATE TBLOGRENCILER SET OGRKULUP=1 WHERE OGRKULUP='Biliþim'
UPDATE TBLOGRENCILER SET OGRKULUP=2 WHERE OGRKULUP='Kitaplýk'
UPDATE TBLOGRENCILER SET OGRKULUP=3 WHERE OGRKULUP='Santranç'
UPDATE TBLOGRENCILER SET OGRKULUP=4 WHERE OGRKULUP='Gezi'

INSERT INTO TBLOGRENCILER (OGRAD,OGRKULUP,OGRSEHIR) VALUES ('Berna',4,'Ankara')

--INNER JOIN: Ýki farklý tablodaki ortak deðerler üzerlerinden bu iki tabloyu birleþtirmeyi saðlar.
SELECT NOTID, DERSAD FROM TBLNOTLAR 
INNER JOIN TBLDERSLER 
ON TBLNOTLAR.DERS=TBLDERSLER.DERSID
/*Yukarýdaki örnekte TBLNOTLAR tablosunda DERSAD olmadýðý için bu bilgiyi TBLDERSLER 
tablosundan çektik. Bunu INNER JOIN sayesinde iki tabloyu birleþtirerek yaptýk.*/

--3 farklý tabloyu foreign key iliþkilerinden yararlanarak birleþtirip kullanma
SELECT NOTID, OGRAD + ' ' + OGRSOYAD AS 'AD SOYAD', DERSAD, SINAV1, SINAV2, SINAV3, ORTALAMA, DURUM 
FROM TBLNOTLAR 
INNER JOIN TBLDERSLER 
ON TBLNOTLAR.DERS=TBLDERSLER.DERSID
INNER JOIN TBLOGRENCILER
ON TBLNOTLAR.OGRENCI=TBLOGRENCILER.OGRID

UPDATE TBLNOTLAR SET ORTALAMA =(SINAV1+SINAV2+SINAV3)/3 WHERE DERS=1
UPDATE TBLNOTLAR SET DURUM=1 WHERE ORTALAMA>=50
UPDATE TBLNOTLAR SET DURUM=0 WHERE ORTALAMA<50

--TBLDERSLER tablosunda Matematik dersine ait olan sýnav not bilgilerini getirmek
--SUB QUERY (ALT SORGU)
SELECT * FROM TBLNOTLAR WHERE DERS=(SELECT DERSID FROM TBLDERSLER WHERE DERSAD='MATEMATÝK')

