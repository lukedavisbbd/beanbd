-- Suppliers
INSERT INTO suppliers VALUES
    (NULL, "BrewMasters Coffee (Pty) Ltd", "+27123456789"),
    (NULL, "Golden Cup Company (Pty) Ltd", "+27654321098"),
    (NULL, "Java Harvest (Pty) Ltd", "+27896543210"),
    (NULL, "DairyFresh (Pty) Ltd", "+27789876543"),
    (NULL, "Smog Grinders (Pty) Ltd", "+27112345678"),
    (NULL, "Decaf Bean Roasters International (Pty) Ltd", "+27665544332");

-- Units
INSERT INTO units VALUES ("units"), ("kg"), ("litres");

-- Stock
INSERT INTO stock VALUES
    (NULL, "Arabica Coffee Beans", "kg", 1000, 200),
    (NULL, "Espresso Coffee Beans", "kg", 500, 100),
    (NULL, "Paper Coffee Cups", "units", 2000, 300),
    (NULL, "Coffee Filters", "units", 5000, 1000),
    (NULL, "Sugar Packets", "kg", 150, 50),
    (NULL, "Milk", "litres", 250, 50),
    (NULL, "Coffee Grinder Machines", "units", 10, 2),
    (NULL, "Decaf Coffee Beans", "kg", 300, 50);

-- Roles
INSERT INTO roles VALUES
    (NULL, "stock_manager"),
    (NULL, "stock_consumer");

-- Users
INSERT INTO users VALUES
    (NULL, "Mr S. Manager"),
    (NULL, "Mr S. Consumer");

-- User Roles
INSERT INTO user_roles VALUES
    (1, 1),
    (2, 2);

-- Stock Orders
INSERT INTO stock_order VALUES
    (NULL, 3, "completed"),
    (NULL, 4, "completed"),
    (NULL, 1, "completed"),
    (NULL, 3, "completed"),
    (NULL, 3, "failed"),
    (NULL, 3, "completed"),
    (NULL, 1, "failed"),
    (NULL, 2, "completed"),
    (NULL, 6, "completed"),
    (NULL, 2, "pending"),
    (NULL, 5, "pending");

-- Stock Order Items

-- Stock order 1 (completed, supplier 3)
INSERT INTO stock_order_items VALUES
    (1, 1, 200),   -- Arabica Coffee Beans, 200 kg
    (1, 2, 100),   -- Espresso Coffee Beans, 100 kg
    (1, 3, 500),   -- Paper Coffee Cups, 500 units
    (1, 4, 1000);  -- Coffee Filters, 1000 units

-- Stock order 2 (completed, supplier 4)
INSERT INTO stock_order_items VALUES
    (2, 5, 50),    -- Sugar Packets, 50 kg
    (2, 6, 100),   -- Milk, 100 litres
    (2, 3, 200);   -- Paper Coffee Cups, 200 units

-- Stock order 3 (completed, supplier 1)
INSERT INTO stock_order_items VALUES
    (3, 1, 300),   -- Arabica Coffee Beans, 300 kg
    (3, 6, 150);   -- Milk, 150 litres

-- Stock order 4 (completed, supplier 3)
INSERT INTO stock_order_items VALUES
    (4, 2, 200),   -- Espresso Coffee Beans, 200 kg
    (4, 3, 1000),  -- Paper Coffee Cups, 1000 units
    (4, 5, 30);    -- Sugar Packets, 30 kg

-- Stock order 5 (failed, supplier 3)
INSERT INTO stock_order_items VALUES
    (5, 4, 1500),  -- Coffee Filters, 1500 units
    (5, 1, 100);   -- Arabica Coffee Beans, 100 kg

-- Stock order 6 (completed, supplier 3)
INSERT INTO stock_order_items VALUES
    (6, 3, 800),   -- Paper Coffee Cups, 800 units
    (6, 2, 150),   -- Espresso Coffee Beans, 150 kg
    (6, 7, 5);     -- Coffee Grinder Machines, 5 units

-- Stock order 7 (failed, supplier 1)
INSERT INTO stock_order_items VALUES
    (7, 2, 250),   -- Espresso Coffee Beans, 250 kg
    (7, 6, 200);   -- Milk, 200 litres

-- Stock order 8 (completed, supplier 2)
INSERT INTO stock_order_items VALUES
    (8, 1, 150),   -- Arabica Coffee Beans, 150 kg
    (8, 3, 300),   -- Paper Coffee Cups, 300 units
    (8, 6, 120);   -- Milk, 120 litres

-- Stock order 9 (completed, supplier 6)
INSERT INTO stock_order_items VALUES
    (9, 8, 100),   -- Decaf Coffee Beans, 100 kg
    (9, 3, 200);   -- Paper Coffee Cups, 200 units

-- Stock order 10 (pending, supplier 2)
INSERT INTO stock_order_items VALUES
    (10, 5, 20),   -- Sugar Packets, 20 kg
    (10, 4, 1000); -- Coffee Filters, 1000 units

-- Stock order 11 (pending, supplier 5)
INSERT INTO stock_order_items VALUES
    (11, 7, 2),    -- Coffee Grinder Machines, 2 units
    (11, 6, 50);   -- Milk, 50 litres

-- Coffee Recipes
INSERT INTO coffee_recipes (name) VALUES
    ("Espresso"),
    ("Cappuccino"),
    ("Latte");

-- Coffee Recipe Ingredients
INSERT INTO coffee_recipe_ingredients VALUES
    (1, 2, 0.05), -- Espresso Coffee Beans, 0.05 kg (50g)
    (1, 6, 0.02); -- Milk, 0.02 litres (20ml)

INSERT INTO coffee_recipe_ingredients VALUES
    (2, 2, 0.05), -- Espresso Coffee Beans, 0.05 kg (50g)
    (2, 6, 0.1),  -- Milk, 0.1 litres (100ml)
    (2, 3, 1);    -- Paper Coffee Cups, 1 unit

INSERT INTO coffee_recipe_ingredients VALUES
    (3, 2, 0.05), -- Espresso Coffee Beans, 0.05 kg (50g)
    (3, 6, 0.15), -- Milk, 0.15 litres (150ml)
    (3, 3, 1);    -- Paper Coffee Cups, 1 unit

-- Coffee Orders
INSERT INTO orders VALUES
    (NULL, 1, 2, '2025-02-17 08:15:00');  -- Espresso

INSERT INTO orders VALUES
    (NULL, 2, 2, '2025-02-17 08:30:00');  -- Cappuccino

INSERT INTO orders VALUES
    (NULL, 3, 2, '2025-02-17 09:00:00');  -- Latte

INSERT INTO orders VALUES
    (NULL, 1, 2, '2025-02-17 10:00:00');  -- Espresso

INSERT INTO orders VALUES
    (NULL, 2, 2, '2025-02-17 12:30:00');  -- Cappuccino
