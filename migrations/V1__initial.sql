CREATE TABLE [stock] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [unit] nvarchar(16) COLLATE Latin1_General_100_CS_AS_SC NOT NULL,
  [quantity] real NOT NULL,
  [warning_threshold] real,
  CONSTRAINT stock_quantity_non_negative CHECK ([quantity] >= 0.0)
)
GO

CREATE TABLE [units] (
  [name] nvarchar(16) COLLATE Latin1_General_100_CS_AS_SC PRIMARY KEY
)
GO

CREATE TABLE [suppliers] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [phone_number] nvarchar(64) NOT NULL
)
GO

CREATE TABLE [stock_orders] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [supplier] int NOT NULL,
  [status] nvarchar(64) COLLATE Latin1_General_100_CS_AS_SC NOT NULL CHECK ([status] IN ('pending', 'completed', 'failed')),
  [ordered_at] datetime2 DEFAULT (GETDATE())
)
GO

CREATE TABLE [stock_order_items] (
  [order] int,
  [stock_item] int,
  [quantity] real NOT NULL CHECK ([quantity] >= 0.0),
  PRIMARY KEY ([order], [stock_item])
)
GO

CREATE TABLE [coffee_recipes] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [coffee_recipe_ingredients] (
  [coffee] int,
  [stock] int,
  [quantity] real NOT NULL CHECK ([quantity] >= 0.0),
  PRIMARY KEY ([coffee], [stock])
)
GO

CREATE TABLE [coffee_orders] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [coffee] int NOT NULL,
  [user] int NOT NULL,
  [ordered_at] datetime2 DEFAULT (GETDATE())
)
GO

CREATE TABLE [users] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [active] bit NOT NULL
)
GO

CREATE TABLE [roles] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(64) UNIQUE NOT NULL
)
GO

CREATE TABLE [user_roles] (
  [user] int,
  [role] int,
  PRIMARY KEY ([user], [role])
)
GO

ALTER TABLE [stock] ADD FOREIGN KEY ([unit]) REFERENCES [units] ([name])
GO

ALTER TABLE [stock_orders] ADD FOREIGN KEY ([supplier]) REFERENCES [suppliers] ([id])
GO

ALTER TABLE [stock_order_items] ADD FOREIGN KEY ([order]) REFERENCES [stock_orders] ([id])
GO

ALTER TABLE [stock_order_items] ADD FOREIGN KEY ([stock_item]) REFERENCES [stock] ([id])
GO

ALTER TABLE [coffee_recipe_ingredients] ADD FOREIGN KEY ([coffee]) REFERENCES [coffee_recipes] ([id])
GO

ALTER TABLE [coffee_recipe_ingredients] ADD FOREIGN KEY ([stock]) REFERENCES [stock] ([id])
GO

ALTER TABLE [coffee_orders] ADD FOREIGN KEY ([coffee]) REFERENCES [coffee_recipes] ([id])
GO

ALTER TABLE [coffee_orders] ADD FOREIGN KEY ([user]) REFERENCES [users] ([id])
GO

ALTER TABLE [user_roles] ADD FOREIGN KEY ([user]) REFERENCES [users] ([id])
GO

ALTER TABLE [user_roles] ADD FOREIGN KEY ([role]) REFERENCES [roles] ([id])
GO
