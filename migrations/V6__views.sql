CREATE VIEW vCoffeeOrdersForThePast30Days
AS
    SELECT CONVERT(DATE,[ordered_at]) as OrderDate, COUNT([coffee]) as NumberOfOrders
    FROM coffee_orders
    WHERE CONVERT(DATE,[ordered_at]) >= DATEADD(DAY, -30, GETDATE())
    GROUP BY CONVERT(DATE,[ordered_at])
GO
