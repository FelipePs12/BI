CREATE TABLE dim_time (
  sk_time NUMBER GENERATED ALWAYS AS IDENTITY,
  calendar_date DATE NOT NULL,
  year NUMBER,
  quarter NUMBER,
  month NUMBER,
  day NUMBER,
  day_of_week NUMBER,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (sk_time)
);

CREATE TABLE dim_customer (
  sk_customer NUMBER GENERATED ALWAYS AS IDENTITY,
  customer_id NUMBER(5) NOT NULL,
  first_name VARCHAR2(45) NOT NULL,
  last_name VARCHAR2(45) NOT NULL,
  email VARCHAR2(50),
  address_id NUMBER(5) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  PRIMARY KEY (sk_customer)
);

CREATE TABLE dim_store (
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

CREATE TABLE fact_sales (
  sk_time NUMBER GENERATED ALWAYS AS IDENTITY,
  sk_customer,
  sk_store,
  time_key NUMBER,
  customer_key NUMBER,
  store_key NUMBER,
  amount NUMBER(5, 2) NOT NULL,
  DT_CARGA DATE DEFAULT SYSDATE,
  FOREIGN KEY (sk_time) REFERENCES dim_time(sk_time),
  FOREIGN KEY (sk_customer) REFERENCES dim_customer(sk_customer),
  FOREIGN KEY (sk_store) REFERENCES dim_store(sk_store)
);
