require 'test_helper'

class RownowaznikiControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rownowaznik = rownowazniki(:one)
  end

  test "should get index" do
    get rownowazniki_url
    assert_response :success
  end

  test "should get new" do
    get new_rownowaznik_url
    assert_response :success
  end

  test "should create rownowaznik" do
    assert_difference('Rownowaznik.count') do
      post rownowazniki_url, params: { rownowaznik: { gatunek_id: @rownowaznik.gatunek_id, nazwautrzymania_id: @rownowaznik.nazwautrzymania_id, sezon_id: @rownowaznik.sezon_id, wartosc: @rownowaznik.wartosc } }
    end

    assert_redirected_to rownowaznik_url(Rownowaznik.last)
  end

  test "should show rownowaznik" do
    get rownowaznik_url(@rownowaznik)
    assert_response :success
  end

  test "should get edit" do
    get edit_rownowaznik_url(@rownowaznik)
    assert_response :success
  end

  test "should update rownowaznik" do
    patch rownowaznik_url(@rownowaznik), params: { rownowaznik: { gatunek_id: @rownowaznik.gatunek_id, nazwautrzymania_id: @rownowaznik.nazwautrzymania_id, sezon_id: @rownowaznik.sezon_id, wartosc: @rownowaznik.wartosc } }
    assert_redirected_to rownowaznik_url(@rownowaznik)
  end

  test "should destroy rownowaznik" do
    assert_difference('Rownowaznik.count', -1) do
      delete rownowaznik_url(@rownowaznik)
    end

    assert_redirected_to rownowazniki_url
  end
end
