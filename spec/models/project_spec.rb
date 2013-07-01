require 'spec_helper'

describe Project do
  it { should validate_presence_of(:production_url) }
  it { should validate_presence_of(:description) }
end