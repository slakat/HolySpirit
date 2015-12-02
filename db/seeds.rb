# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Salata = User.create!(name: 'Sebastian', username: 'Salata', password: 'macoy123', email: 'mail@mail.com')
Tiwi = User.create!(name: 'Patricio', username: 'Patiwi', password: 'Notewe', email: 'mail2@mail.com')
Lore = User.create!(name: 'Loreto', username: 'Lorito', password: '12345678', email: 'mail3@mail.com')
User.create!(name: 'Sebastian Salata', username: 'H4x M3 1F Yu0 C4n', password: 'perro', email: 'mail4@mail.com')
User.create!(name: 'Jesus', username: 'Yisus', password: '42..', email: 'saint@puc.cl')

City.create!(name: 'San Francisco', mayor_id: Salata.id)
sg = City.create!(name: 'Santiago', mayor_id: Lore.id)
viena = City.create!(name: 'Viena',mayor_id: 4)
Uc = City.create!(name: 'PUC',mayor_id: 5)
ms = City.create!(name: 'Redmond',mayor_id: Tiwi.id)

Item.create!(name: 'Bara de poder', description: 'Una bara que brinda poder', effect: 'Aumenta tu multiplicador de score en 1.5x')
Item.create!(name: 'Shuriken', description: 'Arma lanzable japonesa', effect: 'Inhabilita un enemigo.')
Item.create!(name: 'Contraseña maestra', description: 'Una contraseña dinámica sincronizada con un computador cuántico.', effect: 'Tu contraseña no se puede cambiar.')
Item.create!(name: 'Uno Stacko', description: 'Juego de mesa', effect: 'Diviertete!' )
Item.create!(name: 'MissingNo', description: 'Error del juego', effect: 'Error 500.')
Item.create!(name: 'Ichiban', description: 'Lipstick for men', effect: 'Ichiban!.')

Neo = Faction.create!(name: 'Imperio Neo-napoleónico', administrator: Salata, city: Uc, access: 'private')
Faction.create!(name: 'Starbucks', administrator: Lore, city: Uc, access: 'private')
Faction.create!(name: 'M4X1MUM S3CUR1TY', administrator: Salata, city: ms, access: 'public')

Point.create!(name: 'DCC', city: Uc, minCheckInTime: 1440, description: 'HQ of CQ and more.')
Point.create!(name: 'Hogwarts', city: viena, minCheckInTime: 190, description: 'School of magic and wizardry.')
Point.create!(name: 'Metro Los Leones', city: sg, minCheckInTime: 30, description: 'Estación de metro.')
Point.create!(name: 'Metro San Pablo', city: sg, minCheckInTime: 30, description: 'Final de Linea 1, dirección poniente')
Point.create!(name: 'Metro Cal y Canto', city: sg, minCheckInTime: 30, description: 'Estación de metro')
Point.create!(name: 'Metro San Joaquín', city: sg, minCheckInTime: 30, description: 'Estación donde se encuentra el campus SJ de la PUC')

#tablas intermedias

PointsUser.create(point_id: 1, user_id: 1)
PointsUser.create(point_id: 2, user_id: 1)
PointsUser.create(point_id: 1, user_id: 2)
PointsUser.create(point_id: 4, user_id: 1)
PointsUser.create(point_id: 5, user_id: 1)
FactionsUser.create(faction_id: 2, user_id: 2)
FactionsUser.create(faction_id: 1, user_id: 2)
FactionsUser.create(faction_id: 3, user_id: 2)
FactionsUser.create(faction_id: 3, user_id: 1)
FactionsUser.create(faction_id: 1, user_id: 1)
UsersItem.create(user_id:1, item_id:2)
UsersItem.create(user_id:2, item_id:3)
UsersItem.create(user_id:1, item_id:3)
UsersItem.create(user_id:2, item_id:4)
UsersItem.create(user_id:1, item_id:2)
UsersItem.create(user_id:3, item_id:2)
