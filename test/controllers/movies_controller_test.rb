require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "saving a movie should redirect to movies#show" do
  post movies_url, params: { movie: { title: "Home Alone", director: "Chris Colombus", release: "2025-03-13", genre: "Family"} }

  assert_redirected_to movie_path(Movie.last)
  end

  test "should not save a movie without title" do
    movie = Movie.new
    assert_not movie.save, "Saved the movie without a title"
  end

  test "when validation fails, appropriate error is shown" do
    post movies_url, params: { movie: { title: nil, director: "Chris Colombus", release: "2025-03-13", genre: "Family"} }

    assert_response 422
    assert_match "Title can&#39;t be blank", @response.body
    assert_match "Title is too short", @response.body
  end

  test "searching for a movie by title returns the correct movie" do
    movie = Movie.create!(title: "Inception", director: "Christopher Nolan", release: "2010-07-16", genre: "Sci-Fi")
    get movies_url, params: { search: "Inception" }

    assert_response :success
    assert_match movie.title, @response.body
  end

  test "searching for a non-existent movie returns no results" do
    get movies_url, params: { search: "NonExistentMovie" }

    assert_response :success
    assert_no_match /<h2>NonExistentMovie<\/h2>/, @response.body
  end

  test "searching with a blank query returns all movies" do
    movie1 = Movie.create!(title: "Movie 1", director: "Director 1", release: "2020-01-01", genre: "Action")
    movie2 = Movie.create!(title: "Movie 2", director: "Director 2", release: "2021-01-01", genre: "Drama")
    get movies_url, params: { search: "" }

    assert_response :success
    assert_match movie1.title, @response.body
    assert_match movie2.title, @response.body
  end


  #TODO test if
  # blank entry returs everything
  # test if passing in a string returns the expected thing, not return the excluded thing
  # model test 
  # search form test if possible (ETE)
end
