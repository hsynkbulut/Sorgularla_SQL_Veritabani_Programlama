---------- BÖLÜM 13: View ----------
/*
View sayesinde uzun uzun sorgu kodu yazmaktan kurtuluyoruz. 
Özellikle View sihirbazý kullanarak tablo iþlemlerini çok 
daha kolay bir þekilde yapabiliyoruz.
View'larýn dezavantajý: dýþarýdan parametre almamalarýdýr!
*/

--View Oluþturma
CREATE VIEW TEST1
AS
SELECT * FROM TBLKATEGORI

--View'i çaðýrma
SELECT * FROM TEST1

--View'i güncelleme
ALTER VIEW TEST1
AS
SELECT * FROM TBLKATEGORI WHERE KATEGORIID<4

--View'i çaðýrma
SELECT * FROM TEST2

SELECT * FROM TEST3

---------- BÖLÜM 14: Northwind Veri Tabaný ----------
SELECT * FROM Products WHERE CategoryID=(SELECT CategoryID FROM Categories 
WHERE CategoryName='SeaFood') AND UnitsInStock>20 AND
SupplierID=(SELECT SupplierID FROM Suppliers WHERE City='Osaka')

CREATE PROCEDURE TEST1
AS
SELECT * FROM ORDERS WHERE EmployeeID IN(SELECT EmployeeID FROM Employees WHERE City='London')
AND ShipVia=3 AND ShipCountry='France'

EXEC TEST1

CREATE VIEW VIEW1
AS
SELECT OrderID, CompanyName, FirstName + ' ' + LastName AS 'Employee', OrderDate, ShipName, ShipCity, ShipCountry 
FROM ORDERS
INNER JOIN Customers 
ON Orders.CustomerID=Customers.CustomerID
INNER JOIN Employees
ON Orders.EmployeeID=Employees.EmployeeID


SELECT * FROM VIEW1
SELECT * FROM Invoices
SELECT * FROM VIEW2

