class Food < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :user_id, presence: true
  validates_associated :user

  def when_fridged
    DateTime.strptime(self.datetime_created.to_s, "%s").strftime("%Y-%m-%d %l:%M%P")
  end
end
