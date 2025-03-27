class Movie < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }

  # def self.search(search)
  #   if search
  #     movie_title = Movie.find_by(title: search)
  #   elsif
  #     movie_director = Movie.find_by(director: search)
  #   elsif
  #     movie_release = Movie.find_by(release: search)
  #   elsif
  #     movie_genre = Movie.find_by(genre: search)
  #   else
  #     @movies = Movie.all
  #   end
  def self.search(query)
    return all if query.blank?
      @movies = Movie.where("LOWER(title) LIKE '%'||LOWER(?)||'%' OR LOWER(director) LIKE '%'||LOWER(?)||'%' OR LOWER(genre) LIKE '%'||LOWER(?)||'%'", 
               query, query, query)
  end
end
