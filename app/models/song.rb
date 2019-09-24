class Song < ApplicationRecord
    validates :title, presence: true
    validates :artist_name, presence: true
    validates :released, inclusion: { in: [true, false] }

    validates :title, uniqueness: { 
        scope: [:release_year, :artist_name], 
        message: "An artist cannot release the same song name in the same year"
    }

    with_options if: :released do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {less_than_or_equal_to: Date.today.year}
    end

end