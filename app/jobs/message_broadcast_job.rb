class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chats_channel",
                                 message: render_message(message)
  end

  private

  def render_message(message)
    ChatsController.render partial: 'chats/chat', locals: {chat: message}
  end
end
