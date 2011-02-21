require 'test_helper'

class StackOverflowSearchesControllerTest < ActionController::TestCase
  setup do
    @stack_overflow_search = stack_overflow_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stack_overflow_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stack_overflow_search" do
    assert_difference('StackOverflowSearch.count') do
      post :create, :stack_overflow_search => @stack_overflow_search.attributes
    end

    assert_redirected_to stack_overflow_search_path(assigns(:stack_overflow_search))
  end

  test "should show stack_overflow_search" do
    get :show, :id => @stack_overflow_search.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @stack_overflow_search.to_param
    assert_response :success
  end

  test "should update stack_overflow_search" do
    put :update, :id => @stack_overflow_search.to_param, :stack_overflow_search => @stack_overflow_search.attributes
    assert_redirected_to stack_overflow_search_path(assigns(:stack_overflow_search))
  end

  test "should destroy stack_overflow_search" do
    assert_difference('StackOverflowSearch.count', -1) do
      delete :destroy, :id => @stack_overflow_search.to_param
    end

    assert_redirected_to stack_overflow_searches_path
  end
end
