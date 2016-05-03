require 'pusher'

puts "called"
Pusher.app_id = '200634'
Pusher.key = 'd94977f59572dace0f57'
Pusher.secret = '287996b6f46b9cd0c4e7'
Pusher.logger = Rails.logger
Pusher.encrypted = true
