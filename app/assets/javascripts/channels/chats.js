/*jQuery(document).on('turbolinks:load', function() {
//$(document).ready(function() {
  var messages;
  messages = $('#messages');
  $(".chatcard").scrollTop($(".chatcard").prop("scrollHeight"));
  if ($('#messages').length > 0) {
    App.global_chat = App.cable.subscriptions.create({
      channel: "ChatsChannel"
    }, {
      connected: function() {console.log('hello cable');},
      disconnected: function() {},
      received: function(data) {
        messages.append(data['message']);
        $(".chatcard").scrollTop($(".chatcard").prop("scrollHeight"));
      },
      send_message: function(message, author) {
        return this.perform('send_message', {
          message: message,
          author: author
        });
      }
    });
    $('#new_chat').submit(function(e) {
      var $this, textarea;
      $this = $(this);
      textarea = $this.find('#chat_message');
      if(textarea.val() != "") {
        author = $this.find('#chat_author').val();
        if ($.trim(textarea.val()).length > 1) {
          App.global_chat.send_message(textarea.val(), author);
          textarea.val('');
         }
      } else {
        alert("Debe incluir un mensaje");
      }
       e.preventDefault();
       return false;
    });
  }
});*/
