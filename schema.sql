CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  clerk_id VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS drivers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  profile_image_url TEXT,
  car_image_url TEXT,
  car_seats INTEGER CHECK (car_seats > 0),
  rating NUMERIC(2,1) DEFAULT 0.0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rides (
  ride_id SERIAL PRIMARY KEY,
  origin_address TEXT NOT NULL,
  destination_address TEXT NOT NULL,
  origin_latitude NUMERIC(10,7) NOT NULL,
  origin_longitude NUMERIC(11,7) NOT NULL,
  destination_latitude NUMERIC(10,7) NOT NULL,
  destination_longitude NUMERIC(11,7) NOT NULL,
  ride_time TIMESTAMP NOT NULL,
  fare_price NUMERIC(10,2) NOT NULL CHECK (fare_price >= 0),
  payment_status VARCHAR(50) DEFAULT 'pending',
  driver_id INTEGER NOT NULL REFERENCES drivers(id),
  user_id TEXT NOT NULL REFERENCES users(clerk_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_rides_user_id ON rides(user_id);
CREATE INDEX IF NOT EXISTS idx_rides_driver_id ON rides(driver_id);
CREATE INDEX IF NOT EXISTS idx_rides_created_at ON rides(created_at DESC);
