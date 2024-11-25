require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "draft? returns true for draft blog" do
     Post.new(published_at: :nil).draft?
  end
end
