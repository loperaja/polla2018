class ChatNotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(uid)
    ActionCable.server.broadcast "chats_channel",
                                 { typing: true,
                                   uid: uid}
  end

end
