
var input_is_empty = function() {
    var value = $('input#chatbox').val();
    return _.isEmpty( value );
}
var add_message = function( message ) {
  
    var content = '<div class="chat-box-left">' + message.message + '</div>' + 
                   '<div class="chat-box-name-left">' + message.name + ',' + message.timestamp + '</div>' + 
                    '<hr class="hr-clas" />'
    var pretty_message = $('<div></div>').
    html(content);

    $("div#message").append( pretty_message );
}

var addReturnButton = function() {
    $("button#quit").remove();
    var content = '<br><br><button type="button" id = "return"' +
    ' class="btn btn-warning" style="background: #540f2a;">RETURN TO LOBBY</button>';
    $("div#buttons").append(content);
     $('button#return').click( function() {
      console.log('return pressed');
           window.location = '/home/index'; 

     });
       
}

var handleQuit = function(game_id,socket_id) {
   var URI = '/games/move';
 var payload = {
                source: -1,
                target: -1,
                status: "quit",
                piece: -1,
                newposition: -1,
                game_id: game_id,
                socket_id: socket_id
             };

             console.log(payload);

      $.post( URI, payload,function(response){
                 window.location = "/home/index";
                // add_message(response);
            });
       
}

var send_message = function() {
  console.log( 'Button clicked' );
            if ( !input_is_empty() ) {
            var URI = '/chat/message';
            var message = $('input#chatbox').val();
            console.log(message);
            console.log(socket_id);
            var payload = {
                message: message,
               // socket_id: socket_id
             };
           
            $.post( URI, payload,function(response){
                console.log(response)
               
            } );

            $('input#chatbox').val('');

      };

}

var move_piece = function(data,board,game) {
console.log('received data ');
      console.log(data.source);
      console.log(data.target);

      if(data.source == -1 || data.target == -1){
        console.log('quit!!');
       alert("Sorry, unfortunately your oponent left the game!");
       window.location = '/home/index'; 
      }

      var target = data.target;
      var piece = "'" + data.piece + "'";
      var location_string = data.source + "-" + target;

      
      board.move(location_string);
      var move = game.move({
        from: data.source,
        to: data.target,
        promotion: 'q' // NOTE: always promote to a queen for example simplicity
      });
      console.log(move);
      if (move === null) return 'snapback';

      updateStatus(game);

}

var handleOnDrop = function(game,source, target,socket_id) {
 // see if the move is legal
      var move = game.move({
        from: source,
        to: target,
        promotion: 'q' // NOTE: always promote to a queen for example simplicity
      });
      if (move === null) return 'snapback';
      console.log(move);
      // when chat button is pressed.
          
        var moveColor = 'white';
          if (game.turn() === 'b') {
             moveColor = 'black';
        }

            var status = null;
            var winner = null;
            var URI = '/games/move';
            console.log(move.piece);
            console.log(move.to);
            if (game.in_checkmate() === true) {
              status = "checkmate";
                 if(color == moveColor){
                    winner = "no";
                  } else {
                winner = "yes";
               }
               
            }
          else if (game.in_draw() === true) {
            status = "draw";
          }

      // game still on
      else {
        status = "on";
        }
            var payload = {
                source: move.from,
                target: move.to,
                piece: move.piece,
                newposition: ChessBoard.objToFen(move.to),
                socket_id: socket_id,
                status: status,
                winner: winner,
                game_id: game_id
             };

             console.log(payload);

      $.post( URI, payload,function(response){

                // add_message(response);
            });
      updateStatus(game);

}


 var updateStatus = function(game) {
      var status = '';

      var moveColor = 'white';
      if (game.turn() === 'b') {
        moveColor = 'black';
      }

      // checkmate?
      if (game.in_checkmate() === true) {
        if(color == moveColor){
        status = 'Game over! You are in checkmate!, Good try..' + moveColor + ' is in checkmate.';
        } else {
           status = 'Congratulations!! You won!' + moveColor + ' is in checkmate.';
        }
        addReturnButton();
      }

      // draw?
      else if (game.in_draw() === true) {
        status = 'Game over!,Sorry, but no more moves are possible! ';
      }

      // game still on
      else {
        status = moveColor + ' to move';
        if(moveColor == color){
          status += "Your turn!"
        } else {
          status += "Wait for your oponent's move"
        }
        

        // check?
        if (game.in_check() === true) {
          if(color == moveColor){
            status += ', You are in check! ' + moveColor + ' is in check';
          } else {
            status += 'You checked your oponent';
          }
          
        }
      }

      $('#status').html(status);
    //  fenEl.html(game.fen());
    //  pgnEl.html(game.pgn());
    };


$(document).ready( function() {
  // load chess board

  user = $('.temp_information').data('user');
  color = $('.temp_information').data('color');
   game_id = $('.temp_information').data('game');

  console.log("user is " + user);
  console.log("color is " + color);
  console.log("game id " + game_id);
  
   var socket_id = null;
   pusher.connection.bind('connected', function () {
     socket_id = pusher.connection.socket_id;
   });
   var channel = pusher.subscribe('public-chat');
    channel.bind('message-sent', function(data) {
      add_message(data);
    });
    var channel = pusher.subscribe('chess');
     channel.bind('move', function(data) {
      move_piece(data,board,game);

    });
       // when chat button is pressed.
       $('button#send').click( function() {
         send_message();    
      });

   console.log( 'Games DOM LOADED' );

  
    var board,
    game = new Chess(),
    statusEl = $('#status');

    // do not pick up pieces if the game is over
    // only pick up pieces for the side to move
    var onDragStart = function(source, piece, position, orientation) {
      if (game.game_over() === true ||
          (game.turn() === 'w' && piece.search(/^b/) !== -1) ||
          (game.turn() === 'b' && piece.search(/^w/) !== -1)) {
        return false;
      }
    };

    var onDrop = function(source, target) {
       handleOnDrop(game,source,target,socket_id);
    };

    // update the board position after the piece snap 
    // for castling, en passant, pawn promotion
    var onSnapEnd = function() {
      board.position(game.fen());
    };
   
  $('#quit').on('click', function(e){

   var r = confirm("Are you sure you want to quit?");
   if (r == true) {
     handleQuit(game_id,socket_id);
    } 
        // .one() is NOT a typo of .on()
  });
    console.log('Loadng game');
    var cfg = {
      draggable: true,
      position: 'start',
      onDragStart: onDragStart,
      onDrop: onDrop,
      onSnapEnd: onSnapEnd
    };
    board = ChessBoard('board', cfg);
    //var board2 = ChessBoard('board2', cfg);

    updateStatus(game);
        
});



