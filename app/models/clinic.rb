class Clinic < ApplicationRecord
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #field :hospital_id, type: Integer
  #field :name, type: String
  #field :location, type: String
  belongs_to :hospital
  has_many :doctors
  has_many :appointments
end
