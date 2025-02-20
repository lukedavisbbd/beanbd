CREATE FUNCTION udfGetOrdersOfTheDayInTimePeriod(@startTime TIME, @endTime TIME, @day DATE = NULL ) 
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
GO

CREATE FUNCTION udfGetOrdersOfTheMonthInGivenTime(@startTime TIME, @endTime TIME, @year INT, @month INT ) 
RETURNS int
BEGIN
	IF @year IS NULL
        SET @year = YEAR(GETDATE());
	IF @month IS NULL
        SET @month = MONTH(GETDATE());
	DECLARE @NumberOfOrders int;
	SELECT @NumberOfOrders = COUNT(id)
	FROM dbo.coffee_orders
	WHERE (FORMAT(ordered_at, 'HH:mm:ss') BETWEEN '08:00:00' AND '11:59:59') AND (YEAR(ordered_at) = @year) AND (MONTH(ordered_at) = @month);

	RETURN @NumberOfOrders;
END;