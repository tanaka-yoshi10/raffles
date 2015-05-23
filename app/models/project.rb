class Project < ActiveRecord::Base
  has_many :tasks
  validates :name, presence: true

  def code_and_name
    self.code + ' ' + self.name
  end
end
