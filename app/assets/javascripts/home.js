
var input_is_empty = function() {
    var value = $('input#chatbox').val();
    return _.isEmpty( value );
}
var add_message = function( message ) {
    var content = '<span class="timestamp">' + message.timestamp + "</span>" + 
                  '<span class="name">' + message.name + "</span>" + 
                  '<span class="message">' + message.message + "</span>";
      
    var pretty_message = $('<div></div>').
                          addClass('message').
    html(content);

    $("div#message").append( pretty_message );
}


$(document).ready( function() {
        console.log( 'DOM LOADED' );
  // load chess board
     
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
            var payload = {
                message: message,
             };
           // add_message(data)
            $.post( URI, payload,function(response){
                console.log(response)
               // add_message(response);
            } );

            $('input#chatbox').val('');

      };
    });
});