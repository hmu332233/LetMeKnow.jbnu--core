class Major < ActiveRecord::Base
    
    def self.findByName(name)
        majors = Major.where("name like ?", "%" + name + "%")
        
        return majors
    end
    
end
