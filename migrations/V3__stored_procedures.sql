--- Record coffee order (by id) and decrease stock by order ingredients
CREATE PROCEDURE uspRecordCoffeeOrderById (
    @coffee int,
    @user int
)
AS
BEGIN
    BEGIN TRANSACTION;

    IF 'stock_consumer' NOT IN (SELECT [roles].[name] FROM [user_roles] INNER JOIN [roles] ON [user_roles].[role] = [roles].[id] INNER JOIN [users] ON [users].[id] = [user_roles].[user] WHERE [user_roles].[user] = @user AND [users].[active] = 1)
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50000, 'Invalid User: the user does not exist, does not have permission "stock_consumer", or has been deactivated', 0;
    END

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
CREATE PROCEDURE uspRecordCoffeeOrderByName (
    @coffee_name varchar(255),
    @user int
)
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @coffee int;
    SELECT @coffee = [id] FROM [coffee_recipes] WHERE [name] = @coffee_name;

    EXEC uspRecordCoffeeOrderById @coffee, @user;
    COMMIT TRANSACTION;
END
GO

-- Order stock from supplier

CREATE PROCEDURE uspOrderStock
    @stock_id INT,
    @quantity REAL,
    @supplier_id INT,
    @order_id INT OUTPUT
AS
BEGIN
    BEGIN TRANSACTION;
        BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM [suppliers] WHERE [id] = @supplier_id)
        BEGIN
            THROW 50001, 'Invalid Supplier: The specified supplier does not exist.', 1;
        END

        IF NOT EXISTS (SELECT 1 FROM [stock] WHERE [id] = @stock_id)
        BEGIN
            THROW 50002, 'Invalid Stock Item: The specified stock item does not exist.', 1;
        END

        IF @quantity <= 0
        BEGIN
            THROW 50003, 'Invalid Quantity: The quantity must be greater than zero.', 1;
        END

        INSERT INTO [stock_orders] ([supplier], [status])
        VALUES (@supplier_id, 'pending');

        SET @order_id = SCOPE_IDENTITY();

        INSERT INTO [stock_order_items] ([order], [stock_item], [quantity])
        VALUES (@order_id, @stock_id, @quantity);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH       
        ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END;
GO

---mark pending order as completed or failed

CREATE PROCEDURE uspMarkStockOrderStatus
    @order_id INT,
    @status NVARCHAR(64),
    @user INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        IF 'stock_manager' NOT IN (SELECT [roles].[name] FROM [user_roles] INNER JOIN [roles] ON [user_roles].[role] = [roles].[id] INNER JOIN [users] ON [users].[id] = [user_roles].[user] WHERE [user_roles].[user] = @user AND [users].[active] = 1)
        BEGIN
            THROW 50000, 'Invalid User: the user does not exist, does not have permission "stock_manager", or has been deactivated', 0;
        END

        IF NOT EXISTS (SELECT 1 FROM [stock_orders] WHERE [id] = @order_id)
        BEGIN
            THROW 50001, 'Invalid Order: The specified order does not exist.', 1;
        END

        IF @status NOT IN ('failed', 'completed')
        BEGIN
            THROW 50002, 'Invalid Status: The status must be either "failed" or "completed".', 1;
        END

        IF @status = 'failed'
        BEGIN
            UPDATE so
            SET so.status = @status
            FROM [stock_orders] so
            WHERE so.[id] = @order_id;
        END

        ELSE IF @status = 'completed'
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM stock_order_items WHERE [order] = @order_id)
            BEGIN
                THROW 50003, 'Invalid Order Items: The order has no items.', 1;
            END

            UPDATE s
            SET s.[quantity] = s.[quantity] + soi.[quantity]
            FROM stock s
            INNER JOIN [stock_order_items] soi ON s.[id] = soi.[stock_item]
            WHERE soi.[order] = @order_id;

            UPDATE so
            SET so.status = @status,
                so.accepted_by = @user
            FROM [stock_orders] so
            WHERE so.[id] = @order_id;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO

--- get the amount of stock (in their units) consumed for a certain period(days)
CREATE PROCEDURE uspStockConsumption( 
	@start_day int
)
AS
BEGIN
	BEGIN TRANSACTION;
	SELECT 
		[s].[id] AS [stock_id],
		[s].[name] AS [stock_name],
		[s].[unit] AS [stock_unit],
		ROUND(SUM([cci].[quantity]),2) AS [total_consumed] 
	FROM 
		[coffee_orders] AS [co]
	JOIN 
		[coffee_recipes] AS [cr] ON [co].[coffee] = [cr].[id]
	JOIN 
		[coffee_recipe_ingredients] AS [cci] ON [cr].[id] = [cci].[coffee]
	JOIN 
		[stock] AS [s] ON [cci].[stock] = [s].[id]
	WHERE
		[co].[ordered_at] BETWEEN DATEADD(DAY, -@start_day, GETDATE()) AND GETDATE()
	GROUP BY 
		[s].[id], [s].[name], [s].[unit];
	COMMIT TRANSACTION;
END
GO
