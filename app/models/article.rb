class Article < ApplicationRecord
    before_save :generate_slug

    validates :title, presence: true
    validates :description, presence: true
    validates :body, presence: true

    def generate_slug ()
        self.slug = self.title.parameterize 
    end
end
