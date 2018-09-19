require 'saver/DormitoryMenuSaver'

class DormitoryMenuDb < ApplicationRecord
  def self.updateDormitoryMenu
    dormitoryMenuSaver = DormitoryMenuSaver.new
    dormitoryMenuSaver.saveCham()
    dormitoryMenuSaver.saveBasic()
    dormitoryMenuSaver.saveSpecial()
  end
end
