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

  test "add_glucose_level_data" do
    user = User.create!(@user_hash)
    assert_equal [], user.glucose_meters

    user.add_glucose_meter_data(2.5)
    assert_equal 1, user.glucose_meters.count
    assert_equal 1, user.todays_report.count
  end


  test "add_glucose_level_data_perday" do
    user = User.create!(@user_hash)
    assert_equal [], user.glucose_meters
    1.upto(4).each do |x|
      user.add_glucose_meter_data(2.5)
      assert_equal x, user.glucose_meters.count
    end
    assert_equal 4, user.todays_report.count
  end

  test "add_data_perday_raise_exception" do
    user = User.create!(@user_hash)
    assert_equal [], user.glucose_meters
    1.upto(4).each do |x|
      user.add_glucose_meter_data(2.5)
      assert_equal x, user.glucose_meters.count
    end

    assert_raises StandardError  do
      user.add_glucose_meter_data(10.5)
    end
    assert_equal 4, user.todays_report.count
  end

  test "enter_input_check_correctness" do
    user = User.create!(@user_hash)
    assert_equal [], user.glucose_meters
    1.upto(4).each do |x|
      user.add_glucose_meter_data(2.5)
      assert_equal x, user.glucose_meters.count
    end

    # set created_at date to previous day
    user.glucose_meters.update_all(created_at: DateTime.now - 20.days)

    assert_equal 0, user.todays_report.count

    1.upto(4).each do |x|
      user.add_glucose_meter_data(2.5)
      assert_equal x, user.todays_report.count
    end
    assert_equal 4, user.todays_report.count
    assert_equal 8, user.last_month_report.count

    assert_raises StandardError  do
      user.add_glucose_meter_data(10.5)
    end
  end

end
