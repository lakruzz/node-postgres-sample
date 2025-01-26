\c superhero

INSERT INTO city (name) VALUES ('New York');
INSERT INTO city (name) VALUES ('Gotham city');
INSERT INTO city (name) VALUES ('Metropolis');
INSERT INTO city (name) VALUES ('National city');

INSERT INTO superpower (name) VALUES ('web-slinging');
INSERT INTO superpower (name) VALUES ('Superhuman strength');
INSERT INTO superpower (name) VALUES ('Billions of dollars');
INSERT INTO superpower (name) VALUES ('Magic');

INSERT INTO superhero (hero_name, real_name, creation_year, city_id)
    VALUES ('Spider-man', 'Peter Parker', 1962, 1);
INSERT INTO superhero (hero_name, real_name, creation_year, city_id)
    VALUES ('Batman', 'Bruce Wayne', 1939, 2);
INSERT INTO superhero (hero_name, real_name, creation_year, city_id)
    VALUES ('Doctor Strange', 'Dr Stephen Strange', 1963, 1);
INSERT INTO superhero (hero_name, real_name, creation_year, city_id)
    VALUES ('Superwoman', 'Kristin Wells', 1982, 4);

INSERT INTO superhero_powers (hero_id, power_id, level) VALUES (1, 1, 'high');
INSERT INTO superhero_powers (hero_id, power_id, level) VALUES (2, 3, 'high');
INSERT INTO superhero_powers (hero_id, power_id, level) VALUES (3, 4, 'high');
INSERT INTO superhero_powers (hero_id, power_id, level) VALUES (4, 2, 'high');