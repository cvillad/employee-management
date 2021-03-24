class Employee < ApplicationRecord
  enum area:{ accounting: 0, finance: 1, operations: 2, security: 3, human_resources: 4}

end
