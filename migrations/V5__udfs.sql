CREATE FUNCTION dbo.ufnGetOrdersOfTheDayInTimePeriod(@startTime TIME, @endTime TIME, @day DATE = NULL ) 
RETURNS int
BEGIN
	IF @day IS NULL
        SET @day = CAST(GETDATE() AS DATE);

	DECLARE @NumberOfOrders int;
	SELECT @NumberOfOrders = COUNT(id)
	FROM dbo.coffee_orders
	WHERE (FORMAT(ordered_at, 'HH:mm:ss') BETWEEN @startTime AND @endTime) AND (FORMAT(ordered_at, 'yyyy-MM-dd') = @day);

	RETURN @NumberOfOrders;
END;
GO

CREATE FUNCTION dbo.ufnGetOrdersOfTheMonthInGivenTime(@startTime TIME, @endTime TIME, @year INT = NULL, @month INT = NULL ) 
RETURNS int
BEGIN
	IF @year IS NULL
        SET @year = YEAR(GETDATE());
	IF @month IS NULL
        SET @month = MONTH(GETDATE());
	DECLARE @NumberOfOrders int;
	SELECT @NumberOfOrders = COUNT(id)
	FROM dbo.coffee_orders
	WHERE (FORMAT(ordered_at, 'HH:mm:ss') BETWEEN @startTime AND @endTime) AND (YEAR(ordered_at) = @year) AND (MONTH(ordered_at) = @month);

	RETURN @NumberOfOrders;
END;
GO

CREATE FUNCTION dbo.ufnGetOrdersOfTheYeayInGivenTimePeriod(@startTime TIME, @endTime TIME, @year INT = NULL) 
RETURNS int
BEGIN
	IF @year IS NULL
        SET @year = YEAR(GETDATE());
	DECLARE @NumberOfOrders int;
	SELECT @NumberOfOrders = COUNT(id)
	FROM dbo.coffee_orders
	WHERE (FORMAT(ordered_at, 'HH:mm:ss') BETWEEN @startTime AND @endTime) AND (YEAR(ordered_at) = @year)

	RETURN @NumberOfOrders;
END;