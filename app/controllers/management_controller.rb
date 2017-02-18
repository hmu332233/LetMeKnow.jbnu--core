class ManagementController < ApplicationController
  def main
  end

  def major
    @major_list = Major.all
  end

  def message
    @message_list = Message.all.reverse
  end
  
  def backup
  end
end
