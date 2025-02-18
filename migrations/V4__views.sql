CREATE VIEW vLowStock
AS
SELECT * FROM [stock] WHERE [quantity] <= [warning_threshold];