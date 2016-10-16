class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :name, :email, :created_at, :updated_at
  attribute :auth_token, if: :auth_token?

  def created_at
    object.created_at.to_i
  end

  def updated_at
    object.updated_at.to_i
  end

  def auth_token?
    true if object.auth_token
  end
end
