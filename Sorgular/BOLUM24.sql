/*
JOB: SQL Server�da Job lar SQL Server Agent servisi arac�l���yla pek 
�ok i�lemi s�ras�yla belirlenen periyotlarla ger�ekle�tirebilen bir 
i�lemdir. Bir veya daha fazla kez �al��t�r�labilen ve ba�ar� veya 
ba�ar�s�zl�k a��s�ndan izlenebilen bir y�netim g�revi tan�mlamak 
i�in joblar� kullan�r�z.

JOB Nedir?
SQL �zerinde belirlemi� oldu�unuz birtak�m i�leri istedi�imiz aral�klarda 
yapan bir komut k�mesidir. 
JOB arac�l���yla ne yapabiliriz?
�rne�in JOB arac�l���yla Veritaban�m�z�n yede�ini otomatik olarak her saat ba��nda, her dakikada veya 
yar�m saat ba��nda bir alabiliriz. 
*/

USE DbYeni

CREATE TABLE JOBTABLOSU
(
ID INT IDENTITY(1,1),
METIN VARCHAR(20)
)

SELECT * FROM JOBTABLOSU
