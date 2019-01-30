class Post < ApplicationRecord
  validate :equal_post, on: [:create]
  validates :date, :rubygem, :link, :title, :cve, presence: true

  private

  def equal_post
    if Post.where(date: date, rubygem: rubygem, link: link, title: title, cve: cve).present?
      errors.add(:base, 'Such post already exists')
    end
  end
end
