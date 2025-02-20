---Get total coffee orders for a certain period
CREATE FUNCTION udfGetTotalCoffeeOrders (
    @startDate DATE, 
    @endDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @totalOrders INT;

    SELECT @totalOrders = COUNT(*)
    FROM [coffee_orders]
    WHERE CONVERT(DATE,[ordered_at]) >= @startDate AND CONVERT(DATE,[ordered_at]) <= @endDate;

    RETURN @totalOrders;
END
GO
