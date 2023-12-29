class AlphanumericValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless value.match(/\A[a-zA-Z0-9]*\z/).present?
      record.errors.add(attribute, "may only contain of letters and numbers")
    end
  end
end
