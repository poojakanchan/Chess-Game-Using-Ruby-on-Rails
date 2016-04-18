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

#@player1 = User.find(1)
#@stat = Statistic.create(wins: 1 , loses: 1)
#@players1.statistic = @stat

@black_rook_left = Piece.create(name:"black_rook_left",image:"rook_b.png",row:1,col:1)
@black_rook_left.save
@black_rook_right = Piece.create(name:"black_rook_right",image:"rook_b.png",row:1,col:8)
@black_rook_right.save
@black_knight_left = Piece.create(name:"black_knight_left",image:"knight_b.png",row:1,col:2)
@black_knight_left.save
@black_knight_right = Piece.create(name:"black_knight_right",image:"knight_b.png",row:1,col:7)
@black_knight_right.save
@black_bishop_left = Piece.create(name:"black_bishop_left",image:"bishop_b.png",row:1,col:3)
@black_bishop_left.save
@black_bishop_right = Piece.create(name:"black_bishop_right",image:"bishop_b.png",row:1,col:6)
@black_bishop_left.save

@black_queen = Piece.create(name:"black_queen",image:"queen_b.png",row:1,col:4)
@black_queen.save
@black_king = Piece.create(name:"black_king",image:"king_b.png",row:1,col:5)
@black_king.save

8.times do |i|
	@name =  "black_pawn" + (i+1).to_s
	@pawn = Piece.create(name:@name, image: "pawn_b.png",row:2,col:i)
	@pawn.save
end





@white_rook_left = Piece.create(name:"white_rook_left",image:"rook_w.png",row:8,col:1)
@white_rook_left.save
@white_rook_right = Piece.create(name:"white_rook_right",image:"rook_b.png",row:8,col:8)
@white_rook_right.save
@white_knight_left = Piece.create(name:"white_knight_left",image:"knight_w.png",row:8,col:2)
@white_knight_left.save
@white_knight_right = Piece.create(name:"white_knight_right",image:"knight_w.png",row:8,col:7)
@white_knight_right.save
@white_bishop_left = Piece.create(name:"white_bishop_left",image:"bishop_w.png",row:8,col:3)
@white_bishop_left.save
@white_bishop_right = Piece.create(name:"white_bishop_right",image:"bishop_w.png",row:8,col:6)
@white_bishop_right.save

@white_queen = Piece.create(name:"white_queen",image:"queen_w.png",row:8,col:4)
@white_queen.save
@white_king = Piece.create(name:"white_king",image:"king_w.png",row:8,col:5)
@white_king.save

8.times do |i|
	@name =  "white_pawn" + (i+1).to_s
	@pawn = Piece.create(name:@name, image: "pawn_w.png",row:7,col:i)
	@pawn.save
end


