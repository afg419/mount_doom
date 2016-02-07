require "test_helper"

class ItemTest < ActiveSupport::TestCase
  should belong_to :itemable
  should belong_to :skill_set
end
