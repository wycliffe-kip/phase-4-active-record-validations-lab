class Post < ApplicationRecord
    validates :title, presence: true 
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250}
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }

    validate :validate_title_clickbaitiness

    private

    def validate_title_clickbaitiness
        return unless title.present?
        
        clickbait_phrases = ["Won't Believe", "Secret", "Top [number]", "Guess"]

        unless clickbait_phrases.any? { |phrase| title.include?(phrase)}
            errors.add(:title, "should be sufficiently clickbait-y")
        end 
    end 
end
