class Assignment < ActiveRecord::Base
  has_many :comments do
    def first
      find :first
    end
  end
end
