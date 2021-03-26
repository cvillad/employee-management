class EmployeeArea 
  AREAS = %w(accounting finance operations security human_resources)

  def self.options
    EmployeeArea::AREAS.each_with_index.map{|area, index| [area.capitalize.gsub("_"," "), index]}
  end

  def initialize(area)
    @area = area
  end
  
end