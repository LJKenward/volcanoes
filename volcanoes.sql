CREATE DATABASE volcanoes;

\c volcanoes

CREATE TABLE volcanoes (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(200),
  image_url VARCHAR(500),
  height VARCHAR(30),
  status VARCHAR(30)
);

SELECT * FROM volcanoes;

INSERT INTO volcanoes (name, image_url, height, status) VALUES ('Misti', 'http://blog.oregonlive.com/foodday_impact/2009/08/large_goat%20stew.JPG', '4000', 'active');
INSERT INTO volcanoes (name, image_url, height, status) VALUES ('Chitchani', 'http://blackgirlchefswhites.com/wordpress/wp-content/uploads/2011/08/chickepea-feta-salad.jpg', '6000', 'inactive');
INSERT INTO volcanoes (name, image_url, height, status) VALUES ('Wachachina', 'https://s-media-cache-ak0.pinimg.com/736x/b8/be/11/b8be11f8aff109d3e10064cb890bcd4d.jpg', '3453', 'inactive');