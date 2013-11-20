require 'test_helper'

class GameRoundsControllerTest < ActionController::TestCase
  setup do
    @game_round = game_rounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_rounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_round" do
    assert_difference('GameRound.count') do
      post :create, game_round: { ended_at: @game_round.ended_at, name: @game_round.name, started_at: @game_round.started_at }
    end

    assert_redirected_to game_round_path(assigns(:game_round))
  end

  test "should show game_round" do
    get :show, id: @game_round
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_round
    assert_response :success
  end

  test "should update game_round" do
    patch :update, id: @game_round, game_round: { ended_at: @game_round.ended_at, name: @game_round.name, started_at: @game_round.started_at }
    assert_redirected_to game_round_path(assigns(:game_round))
  end

  test "should destroy game_round" do
    assert_difference('GameRound.count', -1) do
      delete :destroy, id: @game_round
    end

    assert_redirected_to game_rounds_path
  end
end
