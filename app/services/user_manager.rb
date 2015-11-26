class UserManager
  ##
  # Returns a user create with the specified attributes.
  # Note that this method will execute ActiveRecord's create method,
  # so you need to check wether the record is persisted? or is a new_record?
  def self.create(user_attrs)
    user = User.create(user_attrs)
    UsersMailer.signup(user.id).deliver_later if user.persisted?
    user
  end
end
