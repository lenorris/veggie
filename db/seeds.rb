# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



User.create!(:username => "quentin", :email => "quentin@example.com", :password => "monkey")

bamboo = Restaurant.new(:name => "New Bamboo Center", :website => "http://www.newbamboocenter.com/", :info => "New Bamboo Center on vuonna 1997 perustettu kiinalainen ravintola. Kiinalaisten ruokien lisäksi ravintolassamme tarjoillaan malesialaisia curryruokia. Pyrimme käyttämään tuoreita raaka-aineita, muutamaa Suomesta vaikeasti saatavissa olevaa erikoisuutta lukuunottamatta.")
bamboobr = Branch.create(:street_address => "Annankatu 29", :city => "Helsinki", :phone => "+358 9 694 3117", :business_hours => "ma-pe 11-22, la 12-22, su 12-22", :email => "newbamboocenter@gmail.com")
bamboo.branches << bamboobr
bamboo.save

zucchini = Restaurant.new(:name => "Zucchini", :info => "Erinomainen lounasravintola, joka päivä tarjolla vegaaninen vaihtoehto.")
zucchinibr = Branch.create(:street_address => "Fabianinkatu 4", :city => "Helsinki", :phone => "+358 9 622 2907", :business_hours => "ma-pe 11-16")
zucchini.branches << zucchinibr
zucchini.save