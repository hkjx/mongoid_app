class Authentication
  include Mongoid::Document
  field :uid, :type => String
  field :provider, :type => String

  belongs_to :user
end
