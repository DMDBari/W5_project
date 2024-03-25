CREATE TABLE IF NOT EXISTS customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS car (
	serial_id SERIAL PRIMARY KEY,
	make VARCHAR NOT NULL,
	model VARCHAR NOT NULL,
	model_year INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE IF NOT EXISTS sales_person (
	sales_id SERIAL PRIMARY KEY,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS invoice (
	invoice_id SERIAL PRIMARY KEY,
	total INTEGER NOT NULL,
	sales_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	serial_id INTEGER NOT NULL,
	FOREIGN KEY(sales_id) REFERENCES sales_person(sales_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(serial_id) REFERENCES car(serial_id)
);

CREATE TABLE IF NOT EXISTS service_ticket (
	service_id SERIAL PRIMARY KEY,
	total INTEGER NOT NULL,
	serial_id INTEGER NOT NULL,
	FOREIGN KEY(serial_id) REFERENCES car(serial_id)
);

CREATE TABLE IF NOT EXISTS mechanic (
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS mechanic_service (
	mechanic_id INTEGER NOT NULL,
	service_id INTEGER NOT NULL,
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(service_id) REFERENCES service_ticket(service_id)
);

INSERT INTO customer(
	first_name,
	last_name
) VALUES (
	'Emily',
	'Smith'
), (
	'John',
	'Martin'
);

INSERT INTO car(
	make,
	model,
	model_year,
	customer_id
) VALUES (
	'Toyota',
	'Prius',
	'2016',
	1
), (
	'Jeep',
	'Grand Cherokee',
	'2010',
	2
);

INSERT INTO sales_person(
	first_name,
	last_name 
) VALUES (
	'Karen',
	'Johnson'
), (
	'Eduardo',
	'Jiminez'
);

INSERT INTO invoice(
	total,
	sales_id,
	customer_id,
	serial_id
) VALUES (
	13000,
	2,
	1,
	1
), (
	5000,
	1,
	2,
	2
);

INSERT INTO service_ticket (
	total,
	serial_id 
) VALUES (
	500,
	1
), (
	400,
	2
);

INSERT INTO mechanic(
	first_name,
	last_name 
) VALUES (
	'Erin',
	'Jackson'
), (
	'Aaron',
	'Jaxson'
);

INSERT INTO mechanic_service(
	mechanic_id,
	service_id
) VALUES (
	1,
	1
), (
	1,
	2
), (
	2,
	1
), (
	2,
	2
);

-- Forgot about the stored procedure part. here is that section.

CREATE OR REPLACE PROCEDURE add_customer (first_name VARCHAR, last_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO customer(first_name, last_name)
	values(first_name, last_name);
END;
$$;

CREATE OR REPLACE PROCEDURE add_car (make VARCHAR, model VARCHAR, model_year INTEGER, customer_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO car(make, model, model_year, customer_id)
	values(make, model, model_year, customer_id);
END;
$$;

CALL add_customer('Michael', 'Owen');
CALL add_customer('Linda', 'Simms');
CALL add_car('Honda', 'Accord', 2019, 3);
CALL add_car('Ford', 'Focus', 2017, 4);





