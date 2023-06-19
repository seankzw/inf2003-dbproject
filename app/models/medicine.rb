class Medicine
  include Mongoid::Document
  #include Mongoid::Timestamps
  store_in collection: "medicines"

  field :name, type: String
  field :price, type: Float
  field :dosage, type: String
  field :instruction, type: String
end
