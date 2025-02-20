-- Suppliers
INSERT INTO [suppliers] ([name], [phone_number]) VALUES
    ('BrewMasters Coffee (Pty) Ltd', '+27123456789'),
    ('Golden Cup Company (Pty) Ltd', '+27654321098'),
    ('Java Harvest (Pty) Ltd', '+27896543210'),
    ('DairyFresh (Pty) Ltd', '+27789876543'),
    ('Smog Grinders (Pty) Ltd', '+27112345678'),
    ('Decaf Bean Roasters International (Pty) Ltd', '+27665544332');

-- Units
INSERT INTO [units] VALUES ('units'), ('kg'), ('litres');

-- Stock
INSERT INTO [stock] ([name], [unit], [quantity], [warning_threshold]) VALUES
    ('Arabica Coffee Beans', 'kg', 1000, 200),
    ('Espresso Coffee Beans', 'kg', 500, 100),
    ('Paper Coffee Cups', 'units', 2000, 300),
    ('Coffee Filters', 'units', 5000, 1000),
    ('Sugar Packets', 'kg', 150, 50),
    ('Milk', 'litres', 250, 50),
    ('Coffee Grinder Machines', 'units', 10, 2),
    ('Decaf Coffee Beans', 'kg', 300, 50);

-- Roles
INSERT INTO [roles] ([name]) VALUES
    ('stock_manager'),
    ('stock_consumer');

-- Users
INSERT INTO [users] ([name], [active]) VALUES
    ('Mr S. Manager', 1),
    ('Mr B. Rista', 1);

-- User Roles
INSERT INTO [user_roles] ([user], [role]) VALUES
    (1, 1),
    (2, 2);

-- Stock Orders
INSERT INTO [stock_orders] ([supplier], [status], [ordered_at], [accepted_by]) VALUES
    (3, 'completed', '2025-02-17 10:00:00', 1),
    (4, 'completed', '2025-02-16 14:30:00', 1),
    (1, 'completed', '2025-02-15 09:45:00', 1),
    (3, 'completed', '2025-02-14 16:20:00', 1),
    (3, 'failed', '2025-02-13 11:00:00', NULL),
    (3, 'completed', '2025-02-12 08:15:00', 1),
    (1, 'failed', '2025-02-11 13:50:00', NULL),
    (2, 'completed', '2025-02-10 17:30:00', 1),
    (6, 'completed', '2025-02-09 12:00:00', 1),
    (2, 'pending', '2025-02-08 15:10:00', NULL),
    (5, 'pending', '2025-02-07 18:25:00', NULL);

-- Stock Order Items

-- Stock order 1 (completed, supplier 3)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (1, 1, 200),   -- Arabica Coffee Beans, 200 kg
    (1, 2, 100),   -- Espresso Coffee Beans, 100 kg
    (1, 3, 500),   -- Paper Coffee Cups, 500 units
    (1, 4, 1000);  -- Coffee Filters, 1000 units

-- Stock order 2 (completed, supplier 4)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (2, 5, 50),    -- Sugar Packets, 50 kg
    (2, 6, 100),   -- Milk, 100 litres
    (2, 3, 200);   -- Paper Coffee Cups, 200 units

-- Stock order 3 (completed, supplier 1)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (3, 1, 300),   -- Arabica Coffee Beans, 300 kg
    (3, 6, 150);   -- Milk, 150 litres

-- Stock order 4 (completed, supplier 3)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (4, 2, 200),   -- Espresso Coffee Beans, 200 kg
    (4, 3, 1000),  -- Paper Coffee Cups, 1000 units
    (4, 5, 30);    -- Sugar Packets, 30 kg

-- Stock order 5 (failed, supplier 3)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (5, 4, 1500),  -- Coffee Filters, 1500 units
    (5, 1, 100);   -- Arabica Coffee Beans, 100 kg

-- Stock order 6 (completed, supplier 3)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (6, 3, 800),   -- Paper Coffee Cups, 800 units
    (6, 2, 150),   -- Espresso Coffee Beans, 150 kg
    (6, 7, 5);     -- Coffee Grinder Machines, 5 units

-- Stock order 7 (failed, supplier 1)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (7, 2, 250),   -- Espresso Coffee Beans, 250 kg
    (7, 6, 200);   -- Milk, 200 litres

-- Stock order 8 (completed, supplier 2)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (8, 1, 150),   -- Arabica Coffee Beans, 150 kg
    (8, 3, 300),   -- Paper Coffee Cups, 300 units
    (8, 6, 120);   -- Milk, 120 litres

-- Stock order 9 (completed, supplier 6)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (9, 8, 100),   -- Decaf Coffee Beans, 100 kg
    (9, 3, 200);   -- Paper Coffee Cups, 200 units

-- Stock order 10 (pending, supplier 2)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (10, 5, 20),   -- Sugar Packets, 20 kg
    (10, 4, 1000); -- Coffee Filters, 1000 units

-- Stock order 11 (pending, supplier 5)
INSERT INTO [stock_order_items] ([order], [stock_item], [quantity]) VALUES
    (11, 7, 2),    -- Coffee Grinder Machines, 2 units
    (11, 6, 50);   -- Milk, 50 litres

-- Coffee Recipes
INSERT INTO [coffee_recipes] ([name]) VALUES
    ('Espresso'),
    ('Cappuccino'),
    ('Latte');

-- Coffee Recipe Ingredients
INSERT INTO [coffee_recipe_ingredients] ([coffee], [stock], [quantity]) VALUES
    (1, 2, 0.05), -- Espresso Coffee Beans, 0.05 kg (50g)
    (1, 6, 0.02); -- Milk, 0.02 litres (20ml)

INSERT INTO [coffee_recipe_ingredients] ([coffee], [stock], [quantity]) VALUES
    (2, 2, 0.05), -- Espresso Coffee Beans, 0.05 kg (50g)
    (2, 6, 0.1),  -- Milk, 0.1 litres (100ml)
    (2, 3, 1);    -- Paper Coffee Cups, 1 unit

INSERT INTO [coffee_recipe_ingredients] ([coffee], [stock], [quantity]) VALUES
    (3, 2, 0.05), -- Espresso Coffee Beans, 0.05 kg (50g)
    (3, 6, 0.15), -- Milk, 0.15 litres (150ml)
    (3, 3, 1);    -- Paper Coffee Cups, 1 unit

-- Coffee Orders
INSERT INTO [coffee_orders] ([coffee], [user], [ordered_at]) VALUES
    (1, 2, '2025-02-17 08:15:00');  -- Espresso

INSERT INTO [coffee_orders] ([coffee], [user], [ordered_at]) VALUES
    (2, 2, '2025-02-17 08:30:00');  -- Cappuccino

INSERT INTO [coffee_orders] ([coffee], [user], [ordered_at]) VALUES
    (3, 2, '2025-02-17 09:00:00');  -- Latte

INSERT INTO [coffee_orders] ([coffee], [user], [ordered_at]) VALUES
    (1, 2, '2025-02-17 10:00:00');  -- Espresso

INSERT INTO [coffee_orders] ([coffee], [user], [ordered_at]) VALUES
    (2, 2, '2025-02-17 12:30:00');  -- Cappuccino
