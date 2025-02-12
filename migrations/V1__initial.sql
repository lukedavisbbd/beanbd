CREATE TABLE `stock` (
  `id` integer PRIMARY KEY,
  `name` varchar(255),
  `unit` varchar(255),
  `quantity` real,
  `warning_threshold` real
);

CREATE TABLE `units` (
  `name` varchar(255) PRIMARY KEY
);

CREATE TABLE `suppliers` (
  `id` integer PRIMARY KEY,
  `name` varchar(255) UNIQUE,
  `phone_number` varchar(255)
);

CREATE TABLE `stock_order` (
  `id` integer PRIMARY KEY,
  `supplier` integer,
  `status` integer
);

CREATE TABLE `stock_order_items` (
  `order` integer,
  `stock_item` integer,
  `quantity` real,
  PRIMARY KEY (`order`, `stock_item`)
);

CREATE TABLE `coffee_recipes` (
  `id` integer PRIMARY KEY,
  `name` varchar(255) UNIQUE
);

CREATE TABLE `coffee_recipe_ingredients` (
  `coffee` integer,
  `stock` integer,
  `quantity` real
);

CREATE TABLE `orders` (
  `id` integer PRIMARY KEY,
  `coffee` integer,
  `user` integer,
  `ordered_at` timestamp
);

CREATE TABLE `users` (
  `id` integer PRIMARY KEY,
  `name` varchar(255) UNIQUE
);

CREATE TABLE `roles` (
  `id` integer PRIMARY KEY,
  `name` varchar(255) UNIQUE
);

CREATE TABLE `user_roles` (
  `user` integer,
  `role` integer,
  PRIMARY KEY (`user`, `role`)
);

ALTER TABLE `stock` ADD FOREIGN KEY (`unit`) REFERENCES `units` (`name`);

ALTER TABLE `stock_order` ADD FOREIGN KEY (`supplier`) REFERENCES `suppliers` (`id`);

ALTER TABLE `stock_order_items` ADD FOREIGN KEY (`order`) REFERENCES `stock_order` (`id`);

ALTER TABLE `stock_order_items` ADD FOREIGN KEY (`stock_item`) REFERENCES `stock` (`id`);

ALTER TABLE `coffee_recipe_ingredients` ADD FOREIGN KEY (`coffee`) REFERENCES `coffee_recipes` (`id`);

ALTER TABLE `coffee_recipe_ingredients` ADD FOREIGN KEY (`stock`) REFERENCES `stock` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`coffee`) REFERENCES `coffee_recipes` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`user`) REFERENCES `users` (`id`);

ALTER TABLE `user_roles` ADD FOREIGN KEY (`user`) REFERENCES `users` (`id`);

ALTER TABLE `user_roles` ADD FOREIGN KEY (`role`) REFERENCES `roles` (`id`);
