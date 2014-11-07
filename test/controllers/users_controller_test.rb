require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user_with_img = {name: 'samy', password: 'secret',
       password_confirmation: 'secret'}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: 'sam', password: 'secret',
       password_confirmation: 'secret' }
     end

     assert_redirected_to users_path
   end


   test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { name: @user.name, password: 'secret', password_confirmation: 'secret' }
    assert_redirected_to users_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test "should create an user with an image" do
    assert_difference 'User.count.to_i + Image.count.to_i', 2 do
      post :create, user: @user_with_img , 
                         uploaded_picture: { uploaded_picture: { name: 'ruby.jpeg', type: 'image/jpeg', data: 'adwaudhaw' }}
      end
      assert_redirected_to users_path
  end
end
