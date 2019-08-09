DROP TABLE albums;
DROP TABLE artists;


CREATE TABLE artists (
  id SERIAl8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE albums (
  id SERIAl8 PRIMARY KEY,
  title VARCHAR(255),
  artist_id INT8 REFERENCES artists(id) ON DELETE CASCADE,
  quantity INT4,
  price FLOAT
);
