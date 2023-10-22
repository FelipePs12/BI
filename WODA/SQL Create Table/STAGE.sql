
CREATE TABLE stcd_store (
  store_id NUMBER(3) NOT NULL,
  manager_staff_id NUMBER(3) NOT NULL,
  address_id NUMBER(5) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (store_id),
  UNIQUE (manager_staff_id),
  FOREIGN KEY (address_id) REFERENCES stcd_address(address_id)
);

CREATE TABLE stcd_customer (
  customer_id NUMBER(5) NOT NULL,
  store_id NUMBER(3) NOT NULL,
  first_name VARCHAR2(45) NOT NULL,
  last_name VARCHAR2(45) NOT NULL,
  email VARCHAR2(50),
  address_id NUMBER(5) NOT NULL,
  active NUMBER(1) DEFAULT 1 NOT NULL,
  create_date TIMESTAMP NOT NULL,
  tipo_pessoa NUMBER(1),
  ds_tpessoa VARCHAR2(100),
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (customer_id),
  FOREIGN KEY (store_id) REFERENCES stcd_store(store_id),
  FOREIGN KEY (address_id) REFERENCES stcd_address(address_id)
);


CREATE TABLE stcd_staff (
  staff_id NUMBER(3) NOT NULL,
  first_name VARCHAR2(45) NOT NULL,
  last_name VARCHAR2(45) NOT NULL,
  address_id NUMBER(5) NOT NULL,
  picture BLOB,
  email VARCHAR2(50),
  store_id NUMBER(3) NOT NULL,
  active NUMBER(1) DEFAULT 1 NOT NULL,
  username VARCHAR2(16) NOT NULL,
  password VARCHAR2(40 CHAR) DEFAULT NULL,
  tipo_pessoa CHAR(1),
  ds_tpessoa VARCHAR2(100),
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (staff_id),
  FOREIGN KEY (store_id) REFERENCES stcd_store(store_id),
  FOREIGN KEY (address_id) REFERENCES stcd_address(address_id)
);

CREATE TABLE stcd_address (
  address_id NUMBER(5) NOT NULL,
  address VARCHAR2(50) NOT NULL,
  address2 VARCHAR2(50),
  district VARCHAR2(20) NOT NULL,
  city_id NUMBER(5) NOT NULL,
  postal_code VARCHAR2(10),
  phone VARCHAR2(20) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (address_id),
  FOREIGN KEY (city_id) REFERENCES stcd_city(city_id)
);



CREATE TABLE stcd_city (
  city_id NUMBER(5) NOT NULL,
  city VARCHAR2(50) NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (city_id)
);


CREATE TABLE stmv_payment (
  payment_id NUMBER(5) NOT NULL,
  customer_id NUMBER(5) NOT NULL,
  staff_id NUMBER(3) NOT NULL,
  rental_id NUMBER(11),
  amount NUMBER(5, 2) NOT NULL,
  payment_date TIMESTAMP NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (payment_id),
  FOREIGN KEY (customer_id) REFERENCES stcd_customer(customer_id),
  FOREIGN KEY (staff_id) REFERENCES stcd_staff(staff_id),
  FOREIGN KEY (rental_id) REFERENCES stcd_rental(rental_id)
);



CREATE TABLE stcd_inventory (
  inventory_id NUMBER(8) NOT NULL,
  film_id NUMBER(5) NOT NULL,
  store_id NUMBER(3) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (inventory_id),
  FOREIGN KEY (film_id) REFERENCES stcd_film(film_id),
  FOREIGN KEY (store_id) REFERENCES stcd_store(store_id),
);


CREATE TABLE stcd_rental (
  rental_id NUMBER(11) NOT NULL,
  rental_date TIMESTAMP NOT NULL,
  inventory_id NUMBER(8) NOT NULL,
  customer_id NUMBER(5) NOT NULL,
  return_date TIMESTAMP,
  staff_id NUMBER(3) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (rental_id),
  UNIQUE (rental_date, inventory_id, customer_id),
  FOREIGN KEY (customer_id) REFERENCES stcd_customer(customer_id),
  FOREIGN KEY (inventory_id) REFERENCES stcd_inventory(inventory_id),
  FOREIGN KEY (staff_id) REFERENCES stcd_staff(staff_id)
);


CREATE TABLE stcd_film (
  film_id NUMBER(5) NOT NULL,
  title VARCHAR2(255) NOT NULL,
  description CLOB,
  release_year NUMBER(4),
  rental_duration NUMBER(3) NOT NULL DEFAULT 3,
  rental_rate NUMBER(4, 2) NOT NULL DEFAULT 4.99,
  length NUMBER(5),
  replacement_cost NUMBER(5, 2) NOT NULL DEFAULT 19.99,
  rating VARCHAR2(5) DEFAULT 'G',
  special_features VARCHAR2(1000),
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (film_id),
  INDEX idx_title (title)
);

