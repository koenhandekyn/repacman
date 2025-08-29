class User < ApplicationRecord
  ROLES = %w[production admin].freeze

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: ROLES }, allow_blank: true

  def self.find_or_create_from_google(auth_hash)
    user = find_or_initialize_by(google_id: auth_hash["uid"])

    if user.new_record?
      user.email = auth_hash["info"]["email"]
      user.name = auth_hash["info"]["name"]
      if auth_hash["info"]["email"].end_with?("@natuly.eu")
        user.role = "production"
      end
      user.save!
    end

    user
  end
end
