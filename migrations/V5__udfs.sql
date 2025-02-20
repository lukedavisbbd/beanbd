---Get total orders for a certain period
CREATE FUNCTION udfGetTotalCoffeeOrders (
    @startDate DATETIME, 
    @endDate DATETIME
)
RETURNS INT
AS
BEGIN
    DECLARE @totalOrders INT;

    SELECT @totalOrders = COUNT(*)
    FROM [coffee_orders]
    WHERE [ordered_at] >= @startDate AND [ordered_at] <= @endDate;

    RETURN @totalOrders;
END
GO
