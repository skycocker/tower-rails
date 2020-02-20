require 'rails_helper'

describe TaskList do
  it { is_expected.to strip_attribute(:name) }
end
