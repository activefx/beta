require 'spec_helper'

RSpec.describe Beta do

  it "must be defined" do
    expect(Beta::VERSION).not_to be_nil
  end

end

