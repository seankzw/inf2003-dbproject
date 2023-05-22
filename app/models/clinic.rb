class Clinic < ApplicationRecord
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #field :hospital_id, type: Integer
  #field :name, type: String
  #field :location, type: String
<<<<<<< HEAD
  belongs_to :hospital
=======
  has_many :doctors
>>>>>>> 3d4249fef921489df0dea33eefb76bb26bf9dd29
end
