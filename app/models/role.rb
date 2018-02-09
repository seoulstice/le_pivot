class Role < ApplicationRecord
  validates_presence_of :name

  def to_sym
    name.to_sym
  end

end
