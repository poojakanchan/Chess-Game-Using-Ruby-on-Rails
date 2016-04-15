require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
  setup do
    @piece = pieces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pieces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create piece" do
    assert_difference('Piece.count') do
      post :create, piece: { col: @piece.col, image: @piece.image, row: @piece.row, type: @piece.type }
    end

    assert_redirected_to piece_path(assigns(:piece))
  end

  test "should show piece" do
    get :show, id: @piece
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @piece
    assert_response :success
  end

  test "should update piece" do
    patch :update, id: @piece, piece: { col: @piece.col, image: @piece.image, row: @piece.row, type: @piece.type }
    assert_redirected_to piece_path(assigns(:piece))
  end

  test "should destroy piece" do
    assert_difference('Piece.count', -1) do
      delete :destroy, id: @piece
    end

    assert_redirected_to pieces_path
  end
end
