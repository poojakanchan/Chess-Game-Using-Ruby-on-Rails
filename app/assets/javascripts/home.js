
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


$(document).ready( function() {
  // load chess board
   var socket_id = null;
   pusher.connection.bind('connected', function () {
   socket_id = pusher.connection.socket_id;
   });
  var channel = pusher.subscribe('public-chat');
 channel.bind('message-sent', function(data) {
      add_message(data);
    });

       // when chat button is pressed.
       $('button#send').click( function() {
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
    });

   console.log( 'DOM LOADED' );

     var socket_id = null;
       pusher.connection.bind('connected', function () {
       socket_id = pusher.connection.socket_id;
       });
     var channel = pusher.subscribe('chess');
     channel.bind('move', function(data) {
      console.log('received data ');
      console.log(data.piece);
      console.log(data.target);

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

      updateStatus();

    });

    var board,
    game = new Chess(),
    statusEl = $('#status'),
    fenEl = $('#fen'),
    pgnEl = $('#pgn');

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
      // see if the move is legal
      var move = game.move({
        from: source,
        to: target,
        promotion: 'q' // NOTE: always promote to a queen for example simplicity
      });
      if (move === null) return 'snapback';
      console.log(move);
      // when chat button is pressed.
     
    

          
            var URI = '/chat/move';
            console.log(move.piece);
            console.log(move.to);

         
         
            var payload = {
                source: move.from,
                target: move.to,
                piece: move.piece,
                newposition: ChessBoard.objToFen(move.to),
                socket_id: socket_id
             };

             console.log(payload);


           

      $.post( URI, payload,function(response){

                // add_message(response);
            });



      

      updateStatus();
    };

    // update the board position after the piece snap 
    // for castling, en passant, pawn promotion
    var onSnapEnd = function() {
      board.position(game.fen());
    };

    var updateStatus = function() {
      var status = '';

      var moveColor = 'White';
      if (game.turn() === 'b') {
        moveColor = 'Black';
      }

      // checkmate?
      if (game.in_checkmate() === true) {
        status = 'Game over, ' + moveColor + ' is in checkmate.';
      }

      // draw?
      else if (game.in_draw() === true) {
        status = 'Game over, drawn position';
      }

      // game still on
      else {
        status = moveColor + ' to move';

        // check?
        if (game.in_check() === true) {
          status += ', ' + moveColor + ' is in check';
        }
      }

      statusEl.html(status);
      fenEl.html(game.fen());
      pgnEl.html(game.pgn());
    };

    var cfg = {
      draggable: true,
      position: 'start',
      onDragStart: onDragStart,
      onDrop: onDrop,
      onSnapEnd: onSnapEnd
    };
    board = ChessBoard('board', cfg);
    //var board2 = ChessBoard('board2', cfg);

    updateStatus();
        
});



