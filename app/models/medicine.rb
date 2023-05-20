class Medicine
  include Mongoid::Document
  #include Mongoid::Timestamps
  store_in collection: "medicines"

  field :name, type: String
  field :quantity, type: Integer
  field :price, type: Float
  field :category, type: String
end
