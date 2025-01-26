\c superhero

SELECT s.hero_name, s.real_name, s.creation_year, c.name AS city,
       p.name AS superpower, sp.level
FROM superhero s
JOIN city c ON s.city_id = c.city_id
JOIN superhero_powers sp ON s.hero_id = sp.hero_id
JOIN superpower p ON sp.power_id = p.power_id;