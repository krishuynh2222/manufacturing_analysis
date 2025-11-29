CREATE TABLE Products (
	ProductID	VARCHAR(50) PRIMARY KEY,
	ProductName	VARCHAR(100),
	Category	VARCHAR(50),
	StandardCost	INT,	
	UnitPrice		INT
);

CREATE TABLE Production (
	WorkOrder	VARCHAR(50),
	ProductID	VARCHAR(50),
	Date		DATE,
	Status		VARCHAR(50),
	PlannedHours	INT,	
	ActualHours		INT,
	ScrapQty		INT,
	ProducedQty		INT,
	DowntimeMinutes	INT,
	Line	VARCHAR(50),
	Shift	VARCHAR(20)
);

CREATE TABLE Sales (
	OrderID	VARCHAR(50),
	Date	DATE,
	ProductID	VARCHAR(50),
	Quantity	INT,
	Region	VARCHAR(50)
);

CREATE TABLE Inventory (
	ProductID	VARCHAR(50),
	StockUnits	INT,
	LeadTimeDays	INT,
	Warehouse	VARCHAR(50),
	LastUpdated	DATE
);

SELECT * FROM Products LIMIT 5;
SELECT * FROM Production LIMIT 5;
SELECT * FROM Sales LIMIT 5;
SELECT * FROM Inventory LIMIT 5;
