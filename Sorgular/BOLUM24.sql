/*
JOB: SQL Server’da Job lar SQL Server Agent servisi aracýlýðýyla pek 
çok iþlemi sýrasýyla belirlenen periyotlarla gerçekleþtirebilen bir 
iþlemdir. Bir veya daha fazla kez çalýþtýrýlabilen ve baþarý veya 
baþarýsýzlýk açýsýndan izlenebilen bir yönetim görevi tanýmlamak 
için joblarý kullanýrýz.

JOB Nedir?
SQL üzerinde belirlemiþ olduðunuz birtakým iþleri istediðimiz aralýklarda 
yapan bir komut kümesidir. 
JOB aracýlýðýyla ne yapabiliriz?
Örneðin JOB aracýlýðýyla Veritabanýmýzýn yedeðini otomatik olarak her saat baþýnda, her dakikada veya 
yarým saat baþýnda bir alabiliriz. 
*/

USE DbYeni

CREATE TABLE JOBTABLOSU
(
ID INT IDENTITY(1,1),
METIN VARCHAR(20)
)

SELECT * FROM JOBTABLOSU
