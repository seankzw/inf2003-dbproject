class Hospital < ApplicationRecord
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #field :name, type: String
  #field :location, type: String
  has_many :clinics
end
