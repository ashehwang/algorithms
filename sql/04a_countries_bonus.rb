# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
  SELECT
  countries.name
  FROM
  countries
  WHERE
  gdp > (select MAX(gdp) from countries group by continent having continent = 'Europe');
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  select
  continent, name, area
  from
  countries
  where
  area IN (select max(area) from countries group by continent)
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
  SELECT
  c1.name, c1.continent
  FROM
  countries as c1
  WHERE
  population > 3 * (
    select MAX(population) from countries as c2 where c1.continent = c2.continent and c1.name != c2.name
  )
  SQL
end
