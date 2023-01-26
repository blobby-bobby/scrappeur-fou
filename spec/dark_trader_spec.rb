require_relative '../lib/dark_trader'

describe "the open_nokigiri method" do
    it "should include an URL" do
      expect(open_nokigiri).not_to be(nil)
    end
end