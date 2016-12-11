require 'test_helper'

class GlucoseMetersControllerTest < ActionController::TestCase
  setup do
    @glucose_meter = glucose_meters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:glucose_meters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create glucose_meter" do
    assert_difference('GlucoseMeter.count') do
      post :create, glucose_meter: { level: @glucose_meter.level, references: @glucose_meter.references }
    end

    assert_redirected_to glucose_meter_path(assigns(:glucose_meter))
  end

  test "should show glucose_meter" do
    get :show, id: @glucose_meter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @glucose_meter
    assert_response :success
  end

  test "should update glucose_meter" do
    patch :update, id: @glucose_meter, glucose_meter: { level: @glucose_meter.level, references: @glucose_meter.references }
    assert_redirected_to glucose_meter_path(assigns(:glucose_meter))
  end

  test "should destroy glucose_meter" do
    assert_difference('GlucoseMeter.count', -1) do
      delete :destroy, id: @glucose_meter
    end

    assert_redirected_to glucose_meters_path
  end
end
