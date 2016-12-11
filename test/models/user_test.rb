require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user_hash = {email: "vijay.sali@gmail.com", password: 1.upto(8).to_a}
  end

  def teardown
    GlucoseMeter.destroy_all
    User.destroy_all
  end

  test "create_normal_user" do
    User.create!(@user_hash)
    assert_equal 1, User.where(email: @user_hash[:email]).count
  end

  test "create_user_without_password" do
    user_hash = { email: @user_hash[:email] }
    assert_raises ActiveRecord::RecordInvalid do
      User.create!(user_hash)
    end
    assert_equal 0, User.where(email: user_hash[:email]).count
  end

  test "create_duplicte_user" do
    User.create!(@user_hash)

    assert_raises ActiveRecord::RecordInvalid do
      User.create!(@user_hash)
    end
    assert_equal 1, User.where(email: @user_hash[:email]).count
  end

  test "check_associations" do
    user = User.create!(@user_hash)
    assert_equal [], user.glucose_meters
  end
end
