class Employee < ApplicationRecord
  enum area:{ accounting: 0, finance: 1, operations: 2, security: 3, human_resources: 4}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, numericality: true, length: { minimum:10, maximum: 10 }
  validates :email, uniqueness: { case_sensitive: false },
                    length: { maximum: 40 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
