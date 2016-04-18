# This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#@piece1 = Piece.create(name: "Queen",row: 1, col: 1)
#@location1 = Location.create(row: 1, col: 1)

#@location1.piece= @piece1

@player1 = User.find(1)
@stat = Statistic.create(wins: 1 , loses: 1)
@players1.statistics = @stat
