require 'test_helper'

class GlucoseMeterTest < ActiveSupport::TestCase

  def setup
  end

  def teardown
    User.destroy_all
    GlucoseMeter.destroy_all
  end

  def test_creation
    first_obj = GlucoseMeter.create(level: 2.2)
    assert_equal 2.2, first_obj.level
    assert_nil first_obj.user_id
    assert_equal 1, GlucoseMeter.all.count
  end

  def test_creation_with_string_char
    assert_raises ActiveRecord::RecordInvalid do
      GlucoseMeter.create!(level: "gello")
    end
  end

  def test_create_with_blank_level
    assert_raises ActiveRecord::RecordInvalid do
      GlucoseMeter.create!(user_id: 1)
    end
  end

end
