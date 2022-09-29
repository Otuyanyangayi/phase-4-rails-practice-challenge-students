class Student < ApplicationRecord
    belongs_to :instructor

    validates :name, presence: true
    validates :age, :numericality=> true, :exclusion => {:in => 0..18}
end
