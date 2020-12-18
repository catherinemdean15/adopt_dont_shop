# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetApplication.delete_all
Pet.delete_all
Shelter.delete_all
shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
pet1 = shelter1.pets.create!(image:"dog.jpg", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
pet2 = shelter2.pets.create!(image:"cat.jpg", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
pet3 = shelter1.pets.create!(image:"dog.jpg", name: "Thorp", description: "dog", approximate_age: 4, sex: "male")
pet4 = shelter2.pets.create!(image:"dog.jpg", name: "Thorn", description: "dog", approximate_age: 4, sex: "male")
pet5 = shelter3.pets.create!(image:"dog.jpg", name: "Horn", description: "dog", approximate_age: 4, sex: "male")
