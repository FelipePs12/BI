
CREATE TABLE dwcd_store (
  sk_store NUMBER GENERATED ALWAYS AS IDENTITY,
  store_id NUMBER(3) NOT NULL,
  manager_staff_id NUMBER(3) NOT NULL,
  address_id NUMBER(5) NOT NULL,
  address VARCHAR2(50) NOT NULL,
  address2 VARCHAR2(50),
  district VARCHAR2(20) NOT NULL,
  city_id NUMBER(5) NOT NULL,
  postal_code VARCHAR2(10),
  phone VARCHAR2(20) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (sk_store)
);



CREATE TABLE dwcd_pessoa (
  sk_pessoa NUMBER GENERATED ALWAYS AS IDENTITY,
  pessoa_id NUMBER(5) NOT NULL,
  store_id NUMBER(3),
  first_name VARCHAR2(45) NOT NULL,
  last_name VARCHAR2(45) NOT NULL,
  email VARCHAR2(50),
  address_id NUMBER(5) NOT NULL,
  address VARCHAR2(50) NOT NULL,
  address2 VARCHAR2(50),
  district VARCHAR2(20) NOT NULL,
  city_id NUMBER(5) NOT NULL,
  postal_code VARCHAR2(10),
  phone VARCHAR2(20) NOT NULL,
  active NUMBER(1) DEFAULT 1 NOT NULL,
  create_date TIMESTAMP NOT NULL,
  tipo_pessoa CHAR(1),
  ds_tpessoa VARCHAR2(100),
  picture BLOB,
  username VARCHAR2(16),
  password VARCHAR2(40 CHAR),
  DT_INIVIG DATE NOT NULL,
  DT_FIMVIG DATE,
  IN_SCDCORR NUMBER(1) DEFAULT 0 NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (sk_pessoa)
);



CREATE TABLE dwcd_cidade (
  sk_cidade NUMBER GENERATED ALWAYS AS IDENTITY,
  cidade_id NUMBER(5) NOT NULL,
  city VARCHAR2(50) NOT NULL,
  country_id NUMBER(5) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (sk_cidade)
);



CREATE TABLE dwmv_payment (
  sk_payment NUMBER GENERATED ALWAYS AS IDENTITY,
  payment_id NUMBER(5) NOT NULL,
  customer_id NUMBER(5) NOT NULL,
  staff_id NUMBER(3) NOT NULL,
  rental_id NUMBER(11),
  amount NUMBER(5, 2) NOT NULL,
  payment_date TIMESTAMP NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (sk_payment),
  FOREIGN KEY (customer_id) REFERENCES dwcd_pessoa(sk_pessoa)
);


CREATE TABLE dwcd_inventory (
  sk_inventory NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
  inventory_id NUMBER(8) NOT NULL,
  film_id NUMBER(5) NOT NULL,
  store_id NUMBER(3) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (sk_inventory),
  FOREIGN KEY (film_id) REFERENCES dwcd_film(film_id),
  FOREIGN KEY (store_id) REFERENCES dwcd_store(store_id)
);



CREATE TABLE dwcd_rental (
  sk_rental NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
  rental_id NUMBER(11) NOT NULL,
  rental_date TIMESTAMP NOT NULL,
  inventory_id NUMBER(8) NOT NULL,
  customer_id NUMBER(5) NOT NULL,
  return_date TIMESTAMP,
  staff_id NUMBER(3) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (sk_rental),
  UNIQUE (rental_date, inventory_id, customer_id),
  FOREIGN KEY (customer_id) REFERENCES dwcd_customer(customer_id),
  FOREIGN KEY (inventory_id) REFERENCES dwcd_inventory(dinventory_id),
  FOREIGN KEY (staff_id) REFERENCES dwcd_staff(staff_id)
);


CREATE TABLE dwcd_film (
  sk_film NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
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
  PRIMARY KEY (sk_film)
);