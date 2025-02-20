CREATE FUNCTION dbo.ufnGetOrdersOfTheDayInTimePeriod(@startTime TIME, @endTime TIME, @day DATE = NULL ) 
RETURNS int
BEGIN
	IF @day IS NULL
        SET @day = CAST(GETDATE() AS DATE);

	DECLARE @NumberOfOrders int;
	SELECT @NumberOfOrders = COUNT(id)
	FROM dbo.coffee_orders
	WHERE (FORMAT(ordered_at, 'HH:mm:ss') BETWEEN '08:00:00' AND '11:59:59') AND (FORMAT(ordered_at, 'yyyy-MM-dd') = @day);

	RETURN @NumberOfOrders;
END;