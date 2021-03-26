class Employee < ApplicationRecord
  before_save { self.email = email.downcase }
  enum area:{ accounting: 0, finance: 1, operations: 2, security: 3, human_resources: 4}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :salary, numericality: {greater_than: 0}
  validates :phone, numericality: {greater_than: 0}
  validates :email, uniqueness: { case_sensitive: false },
                    length: { maximum: 40 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.from_csv(file)
    items = []
    CSV.foreach(file.path, headers: true) do |row|
      puts row
      items << row.to_h
    end
    puts items
    import(items)
  end 

  def self.to_csv
    attributes = %w{id first_name last_name email phone salary area}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

end
