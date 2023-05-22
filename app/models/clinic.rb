class Clinic < ApplicationRecord
  belongs_to :hospital
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #field :hospital_id, type: Integer
  #field :name, type: String
  #field :location, type: String
  has_many :doctors
end
