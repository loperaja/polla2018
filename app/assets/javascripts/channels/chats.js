jQuery(document).on('turbolinks:load', function() {
//$(document).ready(function() {
  var messages;
  var timeout = null;
  messages = $('#messages');
  $(".chatcard").scrollTop($(".chatcard").prop("scrollHeight"));
  if ($('#messages').length > 0) {
    App.global_chat = App.cable.subscriptions.create({
      channel: "ChatsChannel"
    }, {
      connected: function() {console.log('hello cable');},
      disconnected: function() {},
      received: function(data) {
       if(data['message'] != undefined) {
          messages.append(data['message']);
          $(".chatcard").scrollTop($(".chatcard").prop("scrollHeight"));
        } else if(data['typing'] == true) {
          if($("#chat_message").data('uid') != data['uid']) {
            $("#chatNotify").fadeIn();
            timeout = setTimeout(function() {$("#chatNotify").hide();}, 1500);
          }
        }
      },
      send_message: function(message, author) {
        return this.perform('send_message', {
          message: message,
          author: author
        });
      },
      show_status: function(uid) {
        return this.perform('show_status', {
          uid: uid
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

  $("#chat_message").on("keypress", function() {
    var uid = $('#chat_message').data('uid');
    var notif = $("#chatNotify");
    App.global_chat.show_status(uid);
  });
  }
});
