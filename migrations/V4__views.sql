CREATE VIEW vLowStock
AS
    SELECT *
    FROM [stock]
    WHERE [quantity] <= [warning_threshold];
GO

CREATE VIEW vCoffeeOrders
AS
    SELECT
        [coffee_orders].[id] AS order_id,
        [coffee_orders].[coffee] AS coffee_id,
        [coffee_orders].[user] AS user_id,
        [coffee_orders].[ordered_at] AS ordered_at,
        [coffee_recipes].[name] AS coffee_name,
        [users].[name] AS user_name,
        [users].[active] AS user_active
    FROM [coffee_orders]
        JOIN [coffee_recipes] ON [coffee_orders].[coffee]=[coffee_recipes].[id]
        JOIN [dbo].[users] ON [coffee_orders].[user]=[users].[id];
GO

CREATE VIEW vStockOrders
AS
    SELECT
        [stock_orders].[id] AS order_id,
        [stock_orders].[supplier] AS supplier_id,
        [stock_orders].[status] AS order_status,
        [stock_orders].[ordered_at] AS ordered_at,
        [suppliers].[name] AS supplier_name,
        [suppliers].[phone_number] AS phone_number
    FROM [stock_orders]
        JOIN [suppliers] ON [stock_orders].[supplier]=[suppliers].[id];
GO

CREATE VIEW vFailedStockOrders
AS
    SELECT
        [order_id],
        [supplier_id],
        [order_status],
        [ordered_at],
        [supplier_name],
        [phone_number]
    FROM vStockOrders
    WHERE order_status='failed';
GO

CREATE VIEW vCompletedStockOrders
AS
    SELECT
        [order_id],
        [supplier_id],
        [order_status],
        [ordered_at],
        [supplier_name],
        [phone_number]
    FROM vStockOrders
    WHERE order_status='completed';
GO

CREATE VIEW vPendingStockOrders
AS
    SELECT
        [order_id],
        [supplier_id],
        [order_status],
        [ordered_at],
        [supplier_name],
        [phone_number]
    FROM vStockOrders
    WHERE order_status='pending';
GO
