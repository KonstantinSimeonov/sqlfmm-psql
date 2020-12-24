DROP DATABASE IF EXISTS sales_orders_example;

CREATE DATABASE sales_orders_example;

\c sales_orders_example;

CREATE TABLE categories (
    category_id int NOT NULL DEFAULT 0,
    category_description varchar(75) NULL
);

CREATE TABLE customers (
    customer_id int NOT NULL,
    cust_first_name varchar(25) NULL,
    cust_last_name varchar(25) NULL,
    cust_street_address varchar(50) NULL,
    cust_city varchar(30) NULL,
    cust_state varchar(2) NULL,
    cust_zip_code varchar(10) NULL,
    cust_area_code smallint NULL DEFAULT 0,
    cust_phone_number varchar(8) NULL
);

CREATE TABLE employees (
    employee_id int NOT NULL,
    emp_first_name varchar(25) NULL,
    emp_last_name varchar(25) NULL,
    emp_street_address varchar(50) NULL,
    emp_city varchar(30) NULL,
    emp_state varchar(2) NULL,
    emp_zip_code varchar(10) NULL,
    emp_area_code smallint NULL DEFAULT 0,
    emp_phone_number varchar(8) NULL,
        emp_birth_date date NULL
);

CREATE TABLE order_details (
    order_number int NOT NULL DEFAULT 0,
    product_number int NOT NULL DEFAULT 0,
    quoted_price decimal (15, 2) NULL DEFAULT 0,
    quantity_ordered smallint NULL DEFAULT 0
);

CREATE TABLE orders (
    order_number int NOT NULL DEFAULT 0,
    order_date date NULL,
    ship_date date NULL,
    customer_id int NULL DEFAULT 0,
    employee_id int NULL DEFAULT 0
);

CREATE TABLE product_vendors (
    product_number int NOT NULL DEFAULT 0,
    vendor_id int NOT NULL DEFAULT 0,
    wholesale_price decimal (15, 2) NULL DEFAULT 0,
    days_to_deliver smallint NULL DEFAULT 0
);

CREATE TABLE products (
    product_number int NOT NULL DEFAULT 0,
    product_name varchar(50) NULL,
    product_description varchar(100) NULL,
    retail_price decimal (15, 2) NULL DEFAULT 0,
    quantity_on_hand smallint NULL DEFAULT 0,
    category_id int NULL DEFAULT 0
);

CREATE TABLE vendors (
    vendor_id int NOT NULL,
    vend_name varchar(25) NULL,
    vend_street_address varchar(50) NULL,
    vend_city varchar(30) NULL,
    vend_state varchar(2) NULL,
    vend_zip_code varchar(10) NULL,
    vend_phone_number varchar(15) NULL,
    vend_fax_number varchar(15) NULL,
    vend_web_page text NULL,
    vend_email_address varchar(50) NULL
);

CREATE TABLE ztbl_months (
    month_year varchar(15) NOT NULL,
        year_number smallint NOT NULL,
        month_number smallint NOT NULL,
        month_start date NOT NULL,
        month_end date NOT NULL,
        january smallint NOT NULL DEFAULT 0,
        february smallint NOT NULL DEFAULT 0,
        march smallint NOT NULL DEFAULT 0,
        april smallint NOT NULL DEFAULT 0,
        may smallint NOT NULL DEFAULT 0,
        june smallint NOT NULL DEFAULT 0,
        july smallint NOT NULL DEFAULT 0,
        august smallint NOT NULL DEFAULT 0,
        september smallint NOT NULL DEFAULT 0,
        october smallint NOT NULL DEFAULT 0,
        november smallint NOT NULL DEFAULT 0,
        december smallint NOT NULL DEFAULT 0
);

CREATE TABLE ztbl_price_ranges (
        price_category varchar(20) NOT NULL,
        low_price decimal (15,2) NULL,
        high_price decimal (15,2) NULL
);

CREATE TABLE ztbl_purchase_coupons (
        low_spend decimal (15,2) NOT NULL,
        high_spend decimal (15,2) NULL,
        num_coupons smallint NULL DEFAULT 0
);

CREATE TABLE ztbl_seq_numbers (
        sequence int NOT NULL DEFAULT 0
);

ALTER TABLE categories ADD
    CONSTRAINT categories_pk PRIMARY KEY
    (
        category_id
    );

 CREATE INDEX category_id ON categories(category_id);

ALTER TABLE customers ADD
    CONSTRAINT customers_pk PRIMARY KEY
    (
        customer_id
    );

 CREATE INDEX cust_area_code ON customers(cust_area_code);

 CREATE INDEX cust_zip_code ON customers(cust_zip_code);

ALTER TABLE employees ADD
    CONSTRAINT employees_pk PRIMARY KEY
    (
        employee_id
    );

 CREATE INDEX emp_area_code ON employees(emp_area_code);

 CREATE INDEX emp_zip_code ON employees(emp_zip_code);

ALTER TABLE order_details ADD
    CONSTRAINT order_details_pk PRIMARY KEY
    (
        order_number,
        product_number
    );

 CREATE INDEX orders_order_details ON order_details(order_number);

 CREATE INDEX products_order_details ON order_details(product_number);

ALTER TABLE orders ADD
    CONSTRAINT orders_pk PRIMARY KEY
    (
        order_number
    );

 CREATE INDEX customer_id ON orders(customer_id);

 CREATE INDEX employee_id ON orders(employee_id);

ALTER TABLE product_vendors ADD
    CONSTRAINT product_vendors_pk PRIMARY KEY
    (
        product_number,
        vendor_id
    );

 CREATE INDEX products_product_vendors ON product_vendors(product_number);

 CREATE INDEX vendor_id ON product_vendors(vendor_id);

ALTER TABLE products ADD
    CONSTRAINT roducts_pk PRIMARY KEY
    (
        product_number
    );

 CREATE INDEX categories_products ON products(category_id);

ALTER TABLE vendors ADD
    CONSTRAINT vendors_pk PRIMARY KEY
    (
        vendor_id
    );

 CREATE INDEX vend_zip_code ON vendors(vend_zip_code);

ALTER TABLE ztbl_months ADD
     CONSTRAINT ztbl_months_pk PRIMARY KEY
    (
        year_number,
                month_number
    );

 CREATE UNIQUE INDEX month_end ON ztbl_months(month_end);

 CREATE UNIQUE INDEX month_start ON ztbl_months(month_start);

 CREATE UNIQUE INDEX month_year ON ztbl_months(month_year);

ALTER TABLE ztbl_price_ranges ADD
    CONSTRAINT ztbl_price_ranges_pk PRIMARY KEY
    (
        price_category
    );

ALTER TABLE ztbl_purchase_coupons ADD
    CONSTRAINT ztbl_purchase_coupons_pk PRIMARY KEY
    (
        low_spend
    );

 CREATE INDEX num_coupons ON ztbl_purchase_coupons(num_coupons);

ALTER TABLE ztbl_seq_numbers ADD
        CONSTRAINT ztbl_seq_numbers_pk PRIMARY KEY
        (
                sequence
        );

ALTER TABLE order_details ADD
    CONSTRAINT order_details_fk00 FOREIGN KEY
    (
        order_number
    ) REFERENCES orders (
        order_number
    ),
    ADD CONSTRAINT order_details_fk01 FOREIGN KEY
    (
        product_number
    ) REFERENCES products (
        product_number
    );

ALTER TABLE orders ADD
    CONSTRAINT orders_fk00 FOREIGN KEY
    (
        customer_id
    ) REFERENCES customers (
        customer_id
    ),
    ADD CONSTRAINT orders_fk01 FOREIGN KEY
    (
        employee_id
    ) REFERENCES employees (
        employee_id
    );

ALTER TABLE product_vendors ADD
    CONSTRAINT product_vendors_fk00 FOREIGN KEY
    (
        product_number
    ) REFERENCES products (
        product_number
    ),
    ADD CONSTRAINT product_vendors_fk01 FOREIGN KEY
    (
        vendor_id
    ) REFERENCES vendors (
        vendor_id
    );

ALTER TABLE products ADD
    CONSTRAINT products_fk00 FOREIGN KEY
    (
        category_id
    ) REFERENCES categories (
        category_id
    );