DROP TABLE IF EXISTS state_province_dim CASCADE;
DROP TABLE IF EXISTS order_dim CASCADE;
DROP TABLE IF EXISTS product_dim CASCADE;
DROP TABLE IF EXISTS address_line_dim CASCADE;
DROP TABLE IF EXISTS date_dim CASCADE;
DROP TABLE IF EXISTS product_sub_category_dim CASCADE;
DROP TABLE IF EXISTS sale_item_fact CASCADE;


CREATE TABLE state_province_dim(
    state_province_id BIGINT NOT NULL,
    state_province_code VARCHAR(255) NOT NULL,
    country_region_name VARCHAR(255) NOT NULL,
    province_name VARCHAR(255) NOT NULL,
    territory_id BIGINT NOT NULL
);
ALTER TABLE
    state_province_dim ADD PRIMARY KEY(state_province_id);

   
CREATE TABLE order_dim(
    sales_order_id BIGINT NOT NULL,
    order_date_id BIGINT NOT NULL,
    due_date_id BIGINT NOT NULL,
    ship_date_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    ship_to_address_id BIGINT NOT NULL,
    sub_total REAL NOT NULL,
    tax_amt REAL NOT NULL,
    freight REAL NOT NULL,
    online_order_flag BOOLEAN NOT NULL
);
ALTER TABLE
    order_dim ADD PRIMARY KEY(sales_order_id);

   
CREATE TABLE product_dim(
    product_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    product_sub_category_id BIGINT,
    days_to_manufacture BIGINT NOT NULL
);
ALTER TABLE
    product_dim ADD PRIMARY KEY(product_id);

   
CREATE TABLE address_line_dim(
    address_id BIGINT NOT NULL,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(255),
    state_province_id BIGINT NOT NULL,
    postal_code VARCHAR(255) NOT NULL
);
ALTER TABLE
    address_line_dim ADD PRIMARY KEY(address_id);

   
CREATE TABLE date_dim(
    date_id BIGINT NOT NULL,
    full_date DATE NOT NULL,
    day_of_week VARCHAR(255) NOT NULL,
    is_weekday VARCHAR(255) NOT NULL
);
ALTER TABLE
    date_dim ADD PRIMARY KEY(date_id);

   
CREATE TABLE product_sub_category_dim(
    product_sub_category_id BIGINT NOT NULL,
    product_sub_category_name VARCHAR(255) NOT NULL,
    product_category_name VARCHAR(255) NOT NULL
);
ALTER TABLE
    product_sub_category_dim ADD PRIMARY KEY(product_sub_category_id);

   
CREATE TABLE sale_item_fact(
    sale_item_fact_id BIGINT NOT NULL,
    sales_order_id BIGINT NOT NULL,
    order_qty BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    unit_price REAL NOT NULL,
    percent_discount REAL NOT NULL,
    line_total REAL NOT NULL
);
ALTER TABLE
    sale_item_fact ADD PRIMARY KEY(sale_item_fact_id);

   
ALTER TABLE
    order_dim ADD CONSTRAINT orderdim_duedateid_foreign FOREIGN KEY(due_date_id) REFERENCES date_dim(date_id);
ALTER TABLE
    product_dim ADD CONSTRAINT productdim_productsubcategoryid_foreign FOREIGN KEY(product_sub_category_id) REFERENCES product_sub_category_dim(product_sub_category_id);
ALTER TABLE
    address_line_dim ADD CONSTRAINT addresslinedim_stateprovinceid_foreign FOREIGN KEY(state_province_id) REFERENCES state_province_dim(state_province_id);
ALTER TABLE
    sale_item_fact ADD CONSTRAINT saleitemfact_productid_foreign FOREIGN KEY(product_id) REFERENCES product_dim(product_id);
ALTER TABLE
    order_dim ADD CONSTRAINT orderdim_shiptoaddressid_foreign FOREIGN KEY(ship_to_address_id) REFERENCES address_line_dim(address_id);
ALTER TABLE
    sale_item_fact ADD CONSTRAINT saleitemfact_salesorderid_foreign FOREIGN KEY(sales_order_id) REFERENCES order_dim(sales_order_id);
ALTER TABLE
    order_dim ADD CONSTRAINT orderdim_orderdateid_foreign FOREIGN KEY(order_date_id) REFERENCES date_dim(date_id);
ALTER TABLE
    order_dim ADD CONSTRAINT orderdim_shipdateid_foreign FOREIGN KEY(ship_date_id) REFERENCES date_dim(date_id);


