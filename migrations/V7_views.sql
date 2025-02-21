-- view completed stock orders for each item in a month
CREATE VIEW vCompletedStockOrdersForEachMonthByItem
AS
    SELECT s.name, so.status
	  , YEAR(so.ordered_at) AS year
      , MONTH(so.ordered_at) AS month, CONCAT(SUM(si.quantity), ' ', s.unit) AS quantity
    FROM stock_order_items AS si
        JOIN stock_orders AS so
        ON (si.[order] = so.[id])
        JOIN stock AS s
        ON si.[stock_item] = s.id
    WHERE so.status = 'completed'
    GROUP BY s.name, YEAR(so.ordered_at), MONTH(so.ordered_at), so.status,  s.unit
GO