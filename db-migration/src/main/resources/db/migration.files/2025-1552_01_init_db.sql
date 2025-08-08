CREATE SCHEMA IF NOT EXISTS shop;
SET search_path TO shop;

CREATE TABLE customer
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(255)        NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(50)
);
COMMENT ON TABLE customer IS 'Таблица клиентов';

CREATE TABLE category
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    description TEXT
);
COMMENT ON TABLE category IS 'Таблица категорий товаров';

CREATE TABLE product
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255)   NOT NULL,
    price       NUMERIC(10, 2) NOT NULL,
    category_id INT            NOT NULL,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category (id)
);
COMMENT ON TABLE category IS 'Таблица товаров';

CREATE TABLE orders
(
    id           SERIAL PRIMARY KEY,
    customer_id  INT            NOT NULL,
    order_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status       VARCHAR(50)    NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customer (id)
);
COMMENT ON TABLE category IS 'Таблица заказов';

CREATE TABLE order_item
(
    id         SERIAL PRIMARY KEY,
    order_id   INT            NOT NULL,
    product_id INT            NOT NULL,
    quantity   INT            NOT NULL CHECK (quantity > 0),
    price      NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_orderitem_order FOREIGN KEY (order_id) REFERENCES orders (id),
    CONSTRAINT fk_orderitem_product FOREIGN KEY (product_id) REFERENCES product (id)
);
COMMENT ON TABLE category IS 'Таблица товаров в заказах';

CREATE INDEX idx_product_category ON product (category_id);
CREATE INDEX idx_order_customer ON orders (customer_id);
CREATE INDEX idx_orderitem_order ON order_item (order_id);
CREATE INDEX idx_orderitem_product ON order_item (product_id);
