class Sw < ActiveRecord::Base
  JINSU = 'JINSU'
  MEDI = 'MEDI'
  HU = 'HU'
  JUNGDAM = 'JUNGDAM'
  JINSU = 'JINSU'
  STUDENT_HALL = 'STUDENT_HALL'
  
  def self.useDbMenu?(type)    
    case type
      when MEDI
        return useMediDbMenu?
      when HU
        return useHuDbMenu?
      when JUNGDAM
        return useJungdamDbMenu?
      when JINSU
        return useJinsuDbMenu?
      when STUDENT_HALL
        return useStudentHallDbMenu?
    end
  end
  
  def self.useMediDbMenu?
    begin
      useDbMenu = Sw.find(1).use_db_medi
    rescue
      useDbMenu = Sw.create.use_db_medi
    end
    return useDbMenu
  end
  
  def self.useHuDbMenu?
    begin
      useDbMenu = Sw.find(1).use_db_hu
    rescue
      useDbMenu = Sw.create.use_db_hu
    end
    return useDbMenu
  end
  
  def self.useJungdamDbMenu?
    begin
      useDbMenu = Sw.find(1).use_db_jungdam
    rescue
      useDbMenu = Sw.create.use_db_jungdam
    end
    return useDbMenu
  end
  
  def self.useJinsuDbMenu?
    begin
      useDbMenu = Sw.find(1).use_db_jinsu
    rescue
      useDbMenu = Sw.create.use_db_jinsu
    end
    return useDbMenu
  end
  
  def self.useStudentHallDbMenu?
    begin
      useDbMenu = Sw.find(1).use_db_student_hall
    rescue
      useDbMenu = Sw.create.use_db_student_hall
    end
    return useDbMenu
  end
    
end
