require 'rails_helper'

RSpec.describe CachedResult, type: :model do
  context 'validations' do
    subject { CachedResult.new(npi: '12345') }

    it { should validate_presence_of :npi }
    it { should validate_uniqueness_of(:npi).case_insensitive }
  end
end
