
// check if input is empty
var input_is_empty = function() {
    var value = $('input#chatbox').val();
    return _.isEmpty( value );
}

// append messsage to chatbox
var add_message = function( message ) {
  
    var content = '<div class="chat-box-left">' + message.message + '</div>' + 
                   '<div class="chat-box-name-left">' + message.name + ',' + message.timestamp + '</div>' + 
                    '<hr class="hr-clas" />'
    var pretty_message = $('<div></div>').
    html(content);

    $("div#message").append( pretty_message );
}

// when page is loaded
$(document).ready( function() {
        console.log( 'DOM LOADED' );
  // load chess board
   var socket_id = null;
   pusher.connection.bind('connected', function () {
   socket_id = pusher.connection.socket_id;
   });
  var channel = pusher.subscribe('public-chat'); // scubscribe to public chat channel
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
          socket_id: socket_id
       };
           
       $.post( URI, payload,function(response){ // send to controller
          console.log(response)
        } );

        $('input#chatbox').val('');

    };
  });

   // create a new game    
  $('button#create').click( function() {
    var URI = "/games/create"
     
    var payload = {            
        socket_id: socket_id
      };
           
    $.post( URI, payload,function(response){
       console.log(response)
        if(response.redirect) {
          window.location = response.redirectURL + "?user=" + response.user_id + "&color=" + response.color + "&game_id=" + response.game_id;
        }
    });
       
  });

        
});


