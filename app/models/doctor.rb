class Doctor < ApplicationRecord
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #field :clinic_id, type: Integer
  #field :name, type: String
  #field :contact, type: Integer
  #field :email, type: String
  #field :role, type: String
  belongs_to :clinic
  has_many :appointment
end
