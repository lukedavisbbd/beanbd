-- Function to get number of orders in a time period for a given date
CREATE FUNCTION dbo.udfGetOrdersOfTheDayInTimePeriod(@startTime TIME, @endTime TIME, @day DATE = NULL ) 
RETURNS int
BEGIN
	IF @day IS NULL
        SET @day = CAST(GETDATE() AS DATE);

	DECLARE @NumberOfOrders int;
	SELECT @NumberOfOrders = COUNT(id)
	FROM coffee_orders
	WHERE (FORMAT([ordered_at], 'HH:mm:ss') BETWEEN @startTime AND @endTime) AND (FORMAT([ordered_at], 'yyyy-MM-dd') = @day);

	RETURN @NumberOfOrders;
END;
GO

-- Function to get number of orders in a time period for a given month
CREATE FUNCTION dbo.udfGetOrdersOfTheMonthInGivenTime(@startTime TIME, @endTime TIME, @year INT = NULL, @month INT = NULL)
RETURNS int
BEGIN
	IF @year IS NULL
        SET @year = YEAR(GETDATE());
	IF @month IS NULL
        SET @month = MONTH(GETDATE());
	DECLARE @NumberOfOrders int;
	SELECT @NumberOfOrders = COUNT(id)
	FROM coffee_orders
	WHERE (FORMAT([ordered_at], 'HH:mm:ss') BETWEEN @startTime AND @endTime) AND (YEAR([ordered_at]) = @year) AND (MONTH([ordered_at]) = @month);

	RETURN @NumberOfOrders;
END;
GO

-- Function to get the busiest period of the day between morning and afternoon
CREATE FUNCTION dbo.udfGetBusiestPeriodOfTheDay(@day DATE)
RETURNS TABLE
RETURN
(
    SELECT CONVERT(DATE, [ordered_at]) as OrderDate,
	dbo.udfGetOrdersOfTheDayInTimePeriod('08:00:00', '11:59:59', @day) as MorningOrders,
	dbo.udfGetOrdersOfTheDayInTimePeriod('12:00:00', '16:00:00', @day) as AfternoonOrders
FROM [coffee_orders]
WHERE CONVERT(DATE, [ordered_at]) = @day
GROUP BY CONVERT(DATE, [ordered_at])
);
GO

---Get total coffee orders for a certain period
CREATE FUNCTION dbo.udfGetTotalCoffeeOrders (
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
