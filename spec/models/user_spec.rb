require 'rails_helper'

RSpec.describe User do
  subject { create(:user) }

  it 'creates Calendar object' do
    expect { subject }.to change { Calendar.count }.from(0).to(1)
  end
end
