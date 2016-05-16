# README

This is a multi user real time web application: Chess game developed using Ruby on Rails.
The game works as follows: 
- A player enters a game lobby on login. He can start playing either by starting a new game or join an already existing game. When he strarts a new game, he has to wait till someone joins the game.
- The players alternate moves until one player is either checkmated, resigns, or there is a draw. 
- A chat room is provided for communication between players.
- Scores are recorded per account. 
- Login is provided for user authentication
- Social media connectivity to Facebook is provided.
- Technologies Used: Ruby on Rails, PostGreSQL, Javascript, CSS, HTML

## Steps to install the application:
1. Make sure you have Ruby on Rails and PostresSQL installed on your system
1. Download code using git clone
2. Run bundle install on project root directory.
3. Run database migrations using rake db:migrate
4. To run local server WEBrick, run command : rails server
5. You can test it by typing url "localhost:3000" in browser.


