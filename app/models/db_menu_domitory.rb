class DbMenuDomitory < ActiveRecord::Base

    def addMemu(menu)
        
        db_menu = DbMenuDomitory.new
        db_menu.week = menu.week
        db_menu.breakfast = menu.breakfast
        db_menu.lunch = menu.lunch
        db_menu.dinner = menu.dinner
        db_menu.save
        
    end

end
