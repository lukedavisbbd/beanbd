# BeanBD

BeanBD is a system to manage stock of coffee relates supplies.

## Creating the Database

You may have to create an S3 bucket to store the terraform state, the bucket details can be found in `terraform/backend.tf`. Ensure that AWS is configured before running `terraform init` and then `terraform apply`.

## Migrations

Migrations can be found in the `migrations` folder. When migrations are pushed to `master`, they will be executed.

## Tables

> Note: "fk: `table_name`" means that a column is a foreign key to another table.

> Note: the entity relational diagram for this database can be found in `erd.dbml`.

### `stock` Stock Item Type
Columns: `id`, `name`, `unit` (fk: `units`), `quantity`, `warning_threshold`

Example: `(1, 'Coffee Beans', 'kg', 200.0, 50.0)`

This means there are 200kg of coffee beans in stock, and this will show up in the view `v_low_stock` if it's `quantity` falls below `warning_threshold`.

### `units`
Columns: `name`

Examples: `('kg')`, `('litres')`

A type of unit.

### `suppliers`
Columns: `id`, `name`, `phone_number`

Example: `(1, 'Bean Brothers (Pty) Ltd', '+27713025271')`

### `stock_orders`
Columns: `id`, `supplier` (fk: `suppliers`), `status` (one of: `'pending'`, `'completed'`, `'failed'`), `ordered_at`

Example: `(1, 1, 'pending', '2025-02-17 10:00:00')`

Stock order #1 was placed with supplier #1 (Bean Brothers) at the time specified, and is still pending.

### `stock_order_items`
Columns: `order` (fk: `stock_orders`), `stock_item` (fk: `stock`), `quantity`

Example: `(1, 1, 50)`

Stock order #1 has 50kg stock item #1 (coffee beans).

### `coffee_recipes`
Columns: `id`, `name`

Example: `(1, 'Cappuccino')`

### `coffee_recipe_ingredients`
Columns: `coffee` (fk: `coffee_recipes`), `stock` (fk: `stock`), `quantity`

Example: `(1, 1, 0.05)`

Coffee recipe #1 uses 0.05kg (50g) of stock item #1 (coffee beans).

### `coffee_orders`
Columns: `id`, `coffee` (fk: `coffee_recipes`), `user` (fk: `users`), `ordered_at`

Example: `(1, 1, 1)`

User #1 (Mr B. Rista) made coffee recipe #1 (Cappuccino).

### `users`
Columns: `id`, `name`, `active`

Example: `(1, 'Mr B. Rista', 1)`

Mr B. Rista has id #1 and is an active user (has not been soft-deleted).

### `roles`
Columns: `id`, `name`

Example: `(1, 'stock_consumer')`

Defines a user role, used by some stored procedures. The only two roles are `'stock_consumer'` and `'stock_manager'`.

### `user_roles`
Columns: `user` (fk: `users`), `role` (fk: `roles`)

Example: `(1, 1)`

User #1 has role #1.

## Stored Procedures

### `RecordCoffeeOrderById`

Params: `coffee`, `user`

Checks if the `user` has `stock_consumer` role. 

Creates an order in `coffee_orders` for the given coffee ID and user ID.

Decreases `stock` items by the ingredients of a single order of the given coffee recipe.

### `RecordCoffeeOrderByName`

Params: `coffee_name`, `user`

Maps `coffee_name` to its ID and calls `RecordCoffeeOrderById`.

## Views

### `vLowStock`

Selects all `stock` items with `quantity` below its `warning_threshold`.
