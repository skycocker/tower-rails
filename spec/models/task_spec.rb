require 'rails_helper'

describe Task do
  it { is_expected.to strip_attribute(:content) }
end
