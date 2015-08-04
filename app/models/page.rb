class Page < ActiveRecord::Base
    belongs_to :subject
    has_many :sections
    acts_as_list scope: :subjects
    scope :visible, -> { where(visible:  true) }
    scope :invisible, -> { where(visible: false) }
    scope :sorted, -> { order("pages.position ASC") }
    scope :newest_first, -> { order("pages.created_at DESC")}
    validates :title, presence: true
    validates :link, presence: true
end
