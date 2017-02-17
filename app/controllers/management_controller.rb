class ManagementController < ApplicationController
  def main
  end

  def major
  end

  def message
    @message_list = Message.all.reverse
  end
end
