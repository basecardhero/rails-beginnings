class ApplicationForm
  include ActiveModel::API
  include ActiveModel::Attributes
  include ActiveModel::Dirty
  include ActiveModel::Validations::Callbacks
  include ActiveRecord::Normalization

  def initialize(attributes = {})
    super(**attributes)
  end
end
