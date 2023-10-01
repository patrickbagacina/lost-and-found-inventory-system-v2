CREATE SCHEMA IF NOT EXISTS laf;

CREATE TABLE IF NOT EXISTS laf.user (
  user_id SERIAL PRIMARY KEY,
  name varchar(250) NOT NULL,
  username varchar(250) NOT NULL,
  password varchar(250) NOT NULL,
  created_at timestamp NOT NULL DEFAULT NOW(),
  updated_at timestamp NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS laf.lost_item (
  item_id SERIAL PRIMARY KEY,
  category varchar(50) NOT NULL,
  item_type varchar(50) NOT NULL,
  brand varchar(50) NOT NULL,
  description text NOT NULL,
  is_claimed boolean NOT NULL,
  created_at timestamp NOT NULL DEFAULT NOW(),
  updated_at timestamp NOT NULL DEFAULT NOW()
);