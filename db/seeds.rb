# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@u1 = User.create!(name: 'Sebastian', username: 'Salata', password: 'macoy123', email: 'mail@mail.com', administrated_city_id: 1, administrated_faction_id: 1, gm:1)
@u2 = User.create!(name: 'Patricio', username: 'Patiwi', password: 'Notewe', email: 'mail2@mail.com', administrated_city_id: 5, administrated_faction_id: 3)
@u3 = User.create!(name: 'Loreto', username: 'Lorito', password: '12345678', email: 'mail3@mail.com', administrated_city_id: 2, administrated_faction_id: 2)
@u4 = User.create!(name: 'Sebastian Salata', username: 'H4x M3 1F Yu0 C4n', password: 'perro', email: 'mail4@mail.com', administrated_city_id: 3)
@u5 = User.create!(name: 'Jesus', username: 'Yisus', password: '42..', email: 'saint@puc.cl', administrated_city_id: 4)

@c1 = City.create!(name: 'San Francisco', mayor_id: @u1.id)
@c2 = City.create!(name: 'Santiago', mayor_id: @u3.id)
@c3 = City.create!(name: 'Viena',mayor_id: @u4.id)
@c4  = City.create!(name: 'PUC',mayor_id: @u5.id )
@c5 = City.create!(name: 'Redmond',mayor_id: @u2.id)

Item.create!(name: 'Bara de poder', description: 'Una bara que brinda poder', effect: 'Aumenta tu multiplicador de score en 1.5x')
Item.create!(name: 'Shuriken', description: 'Arma lanzable japonesa', effect: 'Inhabilita un enemigo.')
Item.create!(name: 'Contraseña maestra', description: 'Una contraseña dinámica sincronizada con un computador cuántico.', effect: 'Tu contraseña no se puede cambiar.')
Item.create!(name: 'Uno Stacko', description: 'Juego de mesa', effect: 'Diviertete!' )
Item.create!(name: 'MissingNo', description: 'Error del juego', effect: 'Error 500.')
Item.create!(name: 'Ichiban', description: 'Lipstick for men', effect: 'Ichiban!.')

@f1 = Faction.create!(name: 'Imperio Neo-napoleónico', administrator: @u1, city: @c4, access: 'private')
@f2 = Faction.create!(name: 'Starbucks', administrator: @u3, city: @c2, access: 'closed')
@f3 = Faction.create!(name: 'M4X1MUM S3CUR1TY', administrator: @u2, city: @c2, access: 'public')

Point.create!(name: 'DCC', city: @c4, minCheckInTime: 1440, description: 'HQ of CQ and more.', x:-33.49904, y:-70.615099)
Point.create!(name: 'Hogwarts', city: @c3, minCheckInTime: 190, description: 'School of magic and wizardry.')
Point.create!(name: 'Metro Los Leones', city: @c2, minCheckInTime: 30, description: 'Estación de metro.', x:-33.42207384844442, y: -70.60841443715623)
Point.create!(name: 'Metro San Pablo', city: @c2, minCheckInTime: 30, description: 'Final de Linea 1, dirección poniente', x:-33.444227, y:-70.723314)
Point.create!(name: 'Metro Cal y Canto', city: @c2, minCheckInTime: 30, description: 'Estación de metro', x:-33.432715,y:-70.652501)
Point.create!(name: 'Metro San Joaquín', city: @c2, minCheckInTime: 30, description: 'Estación donde se encuentra el campus SJ de la PUC', x:-33.49928, y:-70.615836)

#@u1.administrated_city_id = @c1.id
#@u2.administrated_city_id = @c5.id
#@u3.administrated_city_id = @c2.id
#@u4.administrated_city_id = @c3.id
#@u5.administrated_city_id = @c4.id



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
