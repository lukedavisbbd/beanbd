--- Record coffee order (by id) and decrease stock by order ingredients
CREATE PROCEDURE RecordCoffeeOrderById (
    @coffee int,
    @user int
)
AS
BEGIN
    BEGIN TRANSACTION;

    IF 'stock_consumer' NOT IN (SELECT [roles].[name] FROM [user_roles] INNER JOIN [roles] ON [user_roles].[role] = [roles].[id] INNER JOIN [users] ON [users].[id] = [user_roles].[user] WHERE [user_roles].[user] = @user AND [users].[active] = 1)
        THROW 50000, 'the user does not exist, does not have permission "stock_consumer", or has been deactivated', 0;

    -- Decrease stock by according to coffee recipe ingredients
    UPDATE [stock] SET [stock].[quantity] = [stock].[quantity] - (SELECT COALESCE(SUM([ci].[quantity]), 0.0) FROM [coffee_recipe_ingredients] AS [ci] WHERE [ci].[coffee] = @coffee AND [ci].[stock] = [stock].[id]);

    INSERT INTO [coffee_orders] ([coffee], [user]) VALUES (@coffee, @user);

	DECLARE @coffee_name varchar(255);
	SELECT @coffee_name = [name] FROM [coffee_recipes] WHERE [id] = @coffee;

    DECLARE @user_name varchar(255);
	SELECT @user_name = [name] FROM [users] WHERE [id] = @user;

    PRINT CONCAT('coffee order recorded: ', @coffee_name, ' (', @coffee, ') by user ', @user_name, ' (', @user, ')')

    COMMIT TRANSACTION;
END
GO

--- Record coffee order (by name) and decrease stock by order ingredients
CREATE PROCEDURE RecordCoffeeOrderByName (
    @coffee_name varchar(255),
    @user int
)
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @coffee int;
    SELECT @coffee = [id] FROM [coffee_recipes] WHERE [name] = @coffee_name;

    EXEC RecordCoffeeOrderById @coffee, @user;
    COMMIT TRANSACTION;
END
GO
