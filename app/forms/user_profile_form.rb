# frozen_string_literal: true

class UserProfileForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :nickname, :string
  attribute :bio, :string
  attribute :location, :string
  attribute :website, :string
  attribute :icon
  attribute :header
  attribute :date_of_birth, :date

  VALID_URL = %r{\Ahttps?://[\w!?+/\-~;.,*&@#$%()\[\]]+\z}
  validates :website, format: { with: VALID_URL }
  validates :nickname, presence: true
  validates :date_of_birth, presence: true
  validates :header, presence: true
  validates :icon, presence: true
  validate :date_of_birth_cannot_be_in_the_future, :date_of_birth_invalid_value

  def date_of_birth_cannot_be_in_the_future
    return unless date_of_birth.present? && date_of_birth > Time.zone.today

    errors.add(:date_of_birth, '不正な値です')
  end

  def date_of_birth_invalid_value
    return unless date_of_birth.present? && date_of_birth < Time.zone.today - 140.years

    errors.add(:date_of_birth, '不正な値です')
  end

  def initialize(user, attributes = nil, profile: Profile.new)
    @profile = profile
    @user = user
    attributes ||= default_attributes
    super(attributes)
    set_icon
    set_header
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      @profile.update(nickname:, bio:, location:, website:, header:, icon:)
      @user.update(date_of_birth:)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def set_icon
    self.icon = @profile.icon.blob if icon.blank?
  end

  def set_header
    self.header = @profile.header.blob if header.blank?
  end

  private

  def default_attributes
    {
      nickname: @profile.nickname,
      bio: @profile.bio,
      location: @profile.location,
      website: @profile.website,
      icon: @profile.icon,
      header: @profile.header,
      date_of_birth: @user.date_of_birth
    }
  end
end
