-- banking database

-- create the database
CREATE DATABASE banking;

-- create tables section
-- select database to work on. not needed if schema name is included in queries
USE banking;


-- tables

CREATE TABLE `banking`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(90) NULL,
  `last_name` VARCHAR(90) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC));



CREATE TABLE `banking`.`client_personal_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `date_of_birth` DATE NULL,
  `cnp` BIGINT NOT NULL,
  `address_city` VARCHAR(45) NULL,
  `address_street` VARCHAR(45) NULL,
  `address_building` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `client_id_UNIQUE` (`client_id` ASC) ,
  UNIQUE INDEX `cnp_UNIQUE` (`cnp` ASC) ,
  CONSTRAINT `client_fk`
    FOREIGN KEY (`client_id`)
    REFERENCES `banking`.`client` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


CREATE TABLE `banking`.`accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `iban` VARCHAR(45) NOT NULL,
  `currency` VARCHAR(3) NOT NULL,
  `balance` DECIMAL(12,2) NULL DEFAULT 0.0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `iban_UNIQUE` (`iban` ASC) ,
  INDEX `client_account_fk_idx` (`client_id` ASC) ,
  CONSTRAINT `client_account_fk`
    FOREIGN KEY (`client_id`)
    REFERENCES `banking`.`client` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `banking`.`transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `transaction_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` DECIMAL(12,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `account_fk_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `account_fk`
    FOREIGN KEY (`account_id`)
    REFERENCES `banking`.`accounts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


ALTER TABLE `banking`.`transactions` 
ADD COLUMN `balance_before_transaction` DECIMAL(12,2) NULL AFTER `amount`,
ADD COLUMN `balance_after_transaction` DECIMAL(12,2) NULL AFTER `balance_before_transaction`;


-- populating the tables


-- first insert clients
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Ana', 'Cismaru');
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Liviu', 'Popescu');
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Mihaela', 'Popescu');
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Radu', 'Cismaru');
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Alexandru', 'Tanase');
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Cristian', 'Diaconu');
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Cristian', 'Popescu');
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Ioana', 'Petrovicescu');
INSERT INTO `banking`.`client` (`first_name`, `last_name`) VALUES ('Alina', 'Popescu');


-- insert personal details for clients
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`, `address_city`, `address_street`, `address_building`) VALUES ('1', '1992-05-04', '2920504123456', 'Craiova', 'Lamiitei', 'nr7');
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`, `address_city`, `address_street`, `address_building`) VALUES ('2', '1982-02-03', '1820203123456', 'Bucuresti', 'Matei Basarab', 'bloc 15');
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`, `address_city`, `address_street`, `address_building`) VALUES ('3', '1984-05-09', '2840509123456', 'Bucuresti', 'Matei Basarab', 'bloc 15');
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`, `address_city`, `address_street`, `address_building`) VALUES ('4', '1986-02-25', '1860225191114', 'Craiova', 'Lamiitei', 'nr7');
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`, `address_city`, `address_street`, `address_building`) VALUES ('5', '1986-02-25', '1860225160101', 'Suceava', 'Stefan cel Mare', 'nr9');
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`, `address_city`, `address_street`, `address_building`) VALUES ('6', '1994-08-31', '1940831123456', 'Ploiesti', 'Petrochimiei', 'bloc 17, ap. 6');
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`) VALUES ('7', '2001-09-03', '1010903134781');
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`, `address_city`, `address_street`, `address_building`) VALUES ('8', '1992-01-15', '2950115123456', 'Alba Iulia', 'strada Unirii', 'nr9');
INSERT INTO `banking`.`client_personal_data` (`client_id`, `date_of_birth`, `cnp`, `address_city`, `address_street`, `address_building`) VALUES ('9', '1986-03-11', '2860311123456', 'Pitesti', 'Petrochimistilor', 'bloc 1, ap. 4');


-- create accounts for clients - no need to insert initial balance beacuse that would default to 0.00 since each account is oppened empty.
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('1', 'ROMBKN001171110', 'RON');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('2', 'ROMBKN001171111', 'RON');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('3', 'ROMBKN001171112', 'RON');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('4', 'ROMBKN001171113', 'RON');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('5', 'ROMBKN001171114', 'RON');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('6', 'ROMBKN001171115', 'EUR');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('7', 'ROMBKN001171116', 'RON');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('8', 'ROMBKN001171117', 'RON');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('9', 'ROMBKN001171118', 'RON');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('1', 'ROMBKN001171119', 'EUR');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('4', 'ROMBKN0011711110', 'EUR');
INSERT INTO `banking`.`accounts` (`client_id`, `iban`, `currency`) VALUES ('1', 'ROMBKN0011711111', 'USD');


-- create a transaction - transaction is composed of 1 insert into transactions and 1 update to accounts balance
-- insert in transactions table, getting the current balance of this account
INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(1, 1000, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 1),  
(select balance + 1000 from `banking`.`accounts` where `banking`.`accounts`.`id` = 1));
-- update balance on the account, to reflect this transaction
UPDATE `banking`.`accounts` set balance = balance+1000 where id = 1;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(1, 700, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 1),  
(select balance + 700 from `banking`.`accounts` where `banking`.`accounts`.`id` = 1));
UPDATE `banking`.`accounts` set balance = balance+700 where id = 1;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(1, -300, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 1),  
(select balance - 300 from `banking`.`accounts` where `banking`.`accounts`.`id` = 1));
UPDATE `banking`.`accounts` set balance = balance-300 where id = 1;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(1, -100, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 1),  
(select balance - 100 from `banking`.`accounts` where `banking`.`accounts`.`id` = 1));
UPDATE `banking`.`accounts` set balance = balance-100 where id = 1;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(1, 200, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 1),  
(select balance + 200 from `banking`.`accounts` where `banking`.`accounts`.`id` = 1));
UPDATE `banking`.`accounts` set balance = balance+200 where id = 1;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(2, 700, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 2),  
(select balance + 700 from `banking`.`accounts` where `banking`.`accounts`.`id` = 2));
UPDATE `banking`.`accounts` set balance = balance+700 where id = 2;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(2, -300, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 2),  
(select balance - 300 from `banking`.`accounts` where `banking`.`accounts`.`id` = 2));
UPDATE `banking`.`accounts` set balance = balance-300 where id = 2;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(2, -100, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 2),  
(select balance - 100 from `banking`.`accounts` where `banking`.`accounts`.`id` = 2));
UPDATE `banking`.`accounts` set balance = balance-100 where id = 2;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(2, 200, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 2),  
(select balance + 200 from `banking`.`accounts` where `banking`.`accounts`.`id` = 2));
UPDATE `banking`.`accounts` set balance = balance+200 where id = 2;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(12, 700, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 12),  
(select balance + 700 from `banking`.`accounts` where `banking`.`accounts`.`id` = 12));
UPDATE `banking`.`accounts` set balance = balance+700 where id = 12;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(12, -300, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 12),  
(select balance - 300 from `banking`.`accounts` where `banking`.`accounts`.`id` = 12));
UPDATE `banking`.`accounts` set balance = balance-300 where id = 12;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(12, -100, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 12),  
(select balance - 100 from `banking`.`accounts` where `banking`.`accounts`.`id` = 12));
UPDATE `banking`.`accounts` set balance = balance-100 where id = 1;

INSERT INTO `banking`.`transactions` (`account_id`, `amount`, `balance_before_transaction`, `balance_after_transaction`)
VALUES 
(12, 200, (select balance from `banking`.`accounts` where `banking`.`accounts`.`id` = 12),  
(select balance + 200 from `banking`.`accounts` where `banking`.`accounts`.`id` = 12));
UPDATE `banking`.`accounts` set balance = balance+200 where id = 12;






-- queries

-- get all time statement on a specific account by using the id of the account.
select 
transaction_date,
amount,
balance_before_transaction,
balance_after_transaction
from transactions
where account_id = 1
order by transaction_date desc;

-- get all time statement for specific acocunt using client name and CNP (this is what gives it uniqueness).
select 
transaction_date,
amount,
balance_before_transaction,
balance_after_transaction
from transactions t
inner join accounts a on a.id = t.account_id
inner join client c on c.id = a.client_id
inner join client_personal_data cpd on cpd.client_id = c.id 
where c.first_name = 'Ana' and cpd.cnp = 2920504123456
order by transaction_date desc;


-- get balance for each account of a specific client
select 
a.iban,
a.currency,
a.balance
from accounts a 
inner join client c on c.id = a.client_id
inner join client_personal_data cpd on cpd.client_id = c.id 
where c.first_name = 'Ana' and cpd.cnp = 2920504123456;


-- get the biggest transaction for each account for a specific client. did a left join between accounts and transactions because maybe some of the accounts have no transactions.
-- in this case, account will appear in results, but with null as greatest_transaction
select 
a.iban,
a.currency,
max(t.amount) as greatest_transaction
from accounts a
left join transactions t on t.account_id = a.id
inner join client c on c.id = a.client_id
inner join client_personal_data cpd on cpd.client_id = c.id 
where c.first_name = 'Ana' and cpd.cnp = 2920504123456
group by a.iban;


-- get last transaction on each account for a specific client
select 
a.iban,
a.currency,
tr.amount,
t.last_transaction_date
from accounts a
inner join (select account_id, max(transaction_date) as last_transaction_date from transactions group by account_id) t on t.account_id = a.id
inner join transactions tr on tr.account_id = t.account_id and tr.transaction_date = t.last_transaction_date
inner join client c on c.id = a.client_id
inner join client_personal_data cpd on cpd.client_id = c.id 
where c.first_name = 'Ana' and cpd.cnp = 2920504123456
group by a.iban, tr.amount, t.last_transaction_date;


-- get the number of accounts for each currency
select 
currency,
count(id) 
from
accounts
group by currency; 

-- update the address for all clients that do not have an address with a default one.
update 
client_personal_data
set address_city = 'Bucuresti', address_street = 'Splaiul Independentei', address_building = 'nr1'
where address_city is null;

-- some statistics

-- how many clients does the bank have by the year of their birth
select 
year(date_of_birth),
count(id)
from client_personal_data
group by year(date_of_birth);


-- list all clients that have last name like a given name.
select
c.id,
c.first_name,
c.last_name, 
cpd.address_city
from client c
inner join client_personal_data cpd on cpd.client_id = c.id
where c.last_name like '%Popescu%';

-- list clients that have a specific last name or a specific first name
select
c.id,
c.first_name,
c.last_name, 
cpd.address_city
from client c
inner join client_personal_data cpd on cpd.client_id = c.id
where c.last_name like '%Popescu%' or c.first_name like '%Ana%';


-- list the names and addresses of clients that have more than one account
select
c.id,
c.first_name,
c.last_name, 
cpd.address_city,
count(acc.id)
from client c
inner join client_personal_data cpd on cpd.client_id = c.id
inner join accounts acc on acc.client_id = c.id
group by 
c.id, 
c.first_name,
c.last_name, 
cpd.address_city
having count(acc.id) > 1;

-- list clients born in or after a specific year
select
c.id,
c.first_name,
c.last_name, 
cpd.address_city
from client c
inner join client_personal_data cpd on cpd.client_id = c.id
where year(cpd.date_of_birth) >= 1990;


