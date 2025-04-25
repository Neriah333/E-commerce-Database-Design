This is a group assignment to design an Entity-Relationship Diagram (ERD) and collaboratively build an e-commerce database from scratch.
# Database Schema for a Bookstore Application

This document outlines the database schema for a bookstore application. It includes tables for managing books, authors, publishers, languages, customers, addresses, orders, and shipping information.

## Tables

### `book`

This table stores information about individual books.

| Column Name        | Data Type       | Constraints                     | Description                                  |
|--------------------|-----------------|---------------------------------|----------------------------------------------|
| `book_id`          | `INT`           | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each book.             |
| `title`            | `VARCHAR(255)`  | `NOT NULL`                      | The title of the book.                       |
| `publication_year` | `INT`           |                                 | The year the book was published.             |
| `publisher_id`     | `INT`           | `FOREIGN KEY` (`publisher_id`)  | Foreign key referencing the `publisher` table. |
| `language_id`      | `INT`           | `FOREIGN KEY` (`language_id`)   | Foreign key referencing the `book_language` table.|
| `genre`            | `VARCHAR(100)`  |                                 | The genre of the book.                       |
| `price`            | `DECIMAL(10, 2)`|                                 | The price of the book.                       |

### `author`

This table stores a list of authors.

| Column Name | Data Type      | Constraints                     | Description                          |
|-------------|----------------|---------------------------------|--------------------------------------|
| `author_id` | `INT`          | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each author.   |
| `first_name`| `VARCHAR(100)` | `NOT NULL`                      | The first name of the author.        |
| `last_name` | `VARCHAR(100)` | `NOT NULL`                      | The last name of the author.         |

### `book_author`

This table manages the many-to-many relationship between books and authors.

| Column Name | Data Type | Constraints                 | Description                                     |
|-------------|-----------|-----------------------------|-------------------------------------------------|
| `book_id`   | `INT`     | `FOREIGN KEY` (`book_id`)   | Foreign key referencing the `book` table.       |
| `author_id` | `INT`     | `FOREIGN KEY` (`author_id`) | Foreign key referencing the `author` table.     |
|             |           | `PRIMARY KEY` (`book_id`, `author_id`) | Composite primary key ensuring unique book-author pairs. |

### `book_language`

This table stores the possible languages of books.

| Column Name   | Data Type     | Constraints                     | Description                               |
|---------------|---------------|---------------------------------|-------------------------------------------|
| `language_id` | `INT`         | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each language.      |
| `language_name`| `VARCHAR(50)` | `UNIQUE`, `NOT NULL`            | The name of the language (e.g., English). |

### `publisher`

This table stores a list of publishers for books.

| Column Name     | Data Type       | Constraints                     | Description                               |
|-----------------|-----------------|---------------------------------|-------------------------------------------|
| `publisher_id`  | `INT`           | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each publisher.     |
| `publisher_name`| `VARCHAR(255)`  | `UNIQUE`, `NOT NULL`            | The name of the publisher.                |

### `customer`

This table stores all customer information.

| Column Name    | Data Type      | Constraints                     | Description                     |
|----------------|----------------|---------------------------------|---------------------------------|
| `customer_id`  | `INT`          | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each customer.|
| `first_name`   | `VARCHAR(100)` |                                 | The first name of the customer. |
| `last_name`    | `VARCHAR(100)` |                                 | The last name of the customer.  |
| `email`        | `VARCHAR(100)` | `UNIQUE`                        | The email address of the customer.|
| `phone`        | `VARCHAR(20)`  |                                 | The phone number of the customer.|

### `customer_address`

This table links customers and addresses, allowing multiple addresses per customer.

| Column Name | Data Type | Constraints                 | Description                                          |
|-------------|-----------|-----------------------------|------------------------------------------------------|
| `customer_id`| `INT`     | `FOREIGN KEY` (`customer_id`) | Foreign key referencing the `customer` table.        |
| `address_id` | `INT`     | `FOREIGN KEY` (`address_id`)  | Foreign key referencing the `address` table.         |
| `status_id`  | `INT`     | `FOREIGN KEY` (`status_id`)   | Foreign key referencing the `address_status` table.  |
|             |           | `PRIMARY KEY` (`customer_id`, `address_id`) | Composite primary key for unique customer-address pairs.|

### `address`

This table stores all addresses in the system.

| Column Name     | Data Type      | Constraints                  | Description                               |
|-----------------|----------------|------------------------------|-------------------------------------------|
| `address_id`    | `INT`          | `PRIMARY KEY`, `AUTO_INCREMENT`| Unique identifier for each address.       |
| `street_address`| `VARCHAR(255)` |                              | The street address.                       |
| `city`          | `VARCHAR(100)` |                              | The city of the address.                  |
| `postal_code`   | `VARCHAR(20)`  |                              | The postal code of the address.           |
| `country_id`    | `INT`          | `FOREIGN KEY` (`country_id`) | Foreign key referencing the `country` table.|

### `address_status`

This table stores address statuses (e.g., current, old).

| Column Name | Data Type     | Constraints                     | Description                             |
|-------------|---------------|---------------------------------|-----------------------------------------|
| `status_id` | `INT`         | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each status.      |
| `status_name`| `VARCHAR(50)` | `UNIQUE`                        | The name of the address status (e.g., 'Current', 'Previous').|

### `country`

This table stores countries where addresses are located.

| Column Name  | Data Type      | Constraints                     | Description                       |
|--------------|----------------|---------------------------------|-----------------------------------|
| `country_id` | `INT`          | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each country.|
| `country_name`| `VARCHAR(100)` | `UNIQUE`                        | The name of the country.          |

### `cust_orders`

This table stores information about customer orders.

| Column Name         | Data Type       | Constraints                     | Description                                      |
|---------------------|-----------------|---------------------------------|--------------------------------------------------|
| `order_id`          | `INT`           | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each order.                |
| `customer_id`       | `INT`           | `NOT NULL`, `FOREIGN KEY` (`customer_id`) | Foreign key referencing the `customer` table.      |
| `order_date`        | `DATETIME`      | `NOT NULL`                      | The date and time the order was placed.          |
| `shipping_method_id`| `INT`           | `NOT NULL`, `FOREIGN KEY` (`shipping_method_id`) | Foreign key referencing the `shipping_method` table.|
| `status_id`         | `INT`           | `NOT NULL`, `FOREIGN KEY` (`status_id`)     | Foreign key referencing the `order_status` table.    |
| `total_amount`      | `DECIMAL(10, 2)`| `NOT NULL`                      | The total amount of the order.                   |

### `order_line`

This table stores information about the items in each order.

| Column Name     | Data Type       | Constraints                                  | Description                                     |
|-----------------|-----------------|----------------------------------------------|-------------------------------------------------|
| `order_line_id` | `INT`           | `PRIMARY KEY`, `AUTO_INCREMENT`              | Unique identifier for each order line item.      |
| `order_id`      | `INT`           | `NOT NULL`, `FOREIGN KEY` (`order_id`)       | Foreign key referencing the `cust_orders` table.  |
| `book_id`       | `INT`           | `NOT NULL`, `FOREIGN KEY` (`book_id`)        | Foreign key referencing the `book` table.        |
| `quantity`      | `INT`           | `NOT NULL`, `DEFAULT 1`                      | The quantity of the book in the order line.     |
| `price`         | `DECIMAL(10, 2)`| `NOT NULL`                                   | The price of the book at the time of the order. |
|                 |                 | `UNIQUE` (`order_id`, `book_id`)             | Ensures that a book appears only once per order. |

### `shipping_method`

This table stores information about the shipping methods available for orders.

| Column Name          | Data Type       | Constraints                     | Description                                        |
|----------------------|-----------------|---------------------------------|----------------------------------------------------|
| `shipping_method_id` | `INT`           | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each shipping method.        |
| `shipping_method_name`| `VARCHAR(100)`  | `NOT NULL`                      | The name of the shipping method (e.g., 'Standard').|
| `shipping_cost`      | `DECIMAL(10, 2)`| `NOT NULL`, `DEFAULT 0`         | The cost of the shipping method.                   |
| `delivery_days`      | `TINYINT`       | `NOT NULL`                      | The estimated number of delivery days.             |
| `is_active`          | `BOOLEAN`       | `DEFAULT TRUE`                  | Indicates if the shipping method is currently active.|

### `order_history`

This table stores the history of order statuses.

| Column Name | Data Type | Constraints                 | Description                                       |
|-------------|-----------|-----------------------------|---------------------------------------------------|
| `history_id`| `INT`     | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each history entry.       |
| `order_id`  | `INT`     | `NOT NULL`, `FOREIGN KEY` (`order_id`)   | Foreign key referencing the `cust_orders` table.   |
| `status_id` | `INT`     | `NOT NULL`, `FOREIGN KEY` (`status_id`)  | Foreign key referencing the `order_status` table.  |
| `change_date`| `DATETIME`| `NOT NULL`                      | The date and time the order status was changed. |

### `order_status`

This table stores the possible statuses of orders.

| Column Name | Data Type     | Constraints                     | Description                     |
|-------------|---------------|---------------------------------|---------------------------------|
| `status_id` | `INT`         | `PRIMARY KEY`, `AUTO_INCREMENT` | Unique identifier for each status.|
| `status_name`| `VARCHAR(50)` | `NOT NULL`, `UNIQUE`            | The name of the order status (e.g., 'Pending', 'Shipped', 'Delivered').|

Submitted by Group 257
Names:
1.Pheobe Nerea Nyawanda


 
