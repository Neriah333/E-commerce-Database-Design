/*The following are tables for out e-commerce platform */
-- -- This SQL script creates a database schema for the e-commerce platform
CREATE DATABASE Ecommerce;

-- This is for using the created database
USE Ecommerce;
-- Stores brand-related data
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    logo_url VARCHAR(255)
);

-- Classifies products into categories (e.g., clothing, electronics)
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

-- Groups sizes into categories (e.g., clothing sizes, shoe sizes)
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

-- Lists specific sizes (e.g., S, M, L, 42)
CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT,
    size_value VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- Manages available color options
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_name VARCHAR(100) NOT NULL UNIQUE,
    color_code VARCHAR(20), -- e.g., #FF0000 for red
    description TEXT
);

-- Groups attributes into categories (e.g., physical, technical)
CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

-- Defines types of attributes (e.g., text, number, boolean)
CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Stores custom attributes (e.g., material, weight)
CREATE TABLE product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    attribute_category_id INT,
    attribute_type_id INT,
    attribute_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

-- Stores general product details (name, brand, base price)
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_id INT,
    category_id INT,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- Links a product to its variations (e.g., size, color)
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    size_option_id INT,
    color_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    UNIQUE KEY unique_variation (product_id, size_option_id, color_id) -- Ensures unique combinations
);

-- Represents purchasable items with specific variations
CREATE TABLE product_item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    variation_id INT,
    sku VARCHAR(255) UNIQUE, -- Stock Keeping Unit
    stock_quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL, -- Price for this specific variation
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
);

-- Stores product image URLs or file references
CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_item_id INT,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    is_thumbnail BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(item_id)
);
