require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  should belong_to :location
  should belong_to :category
  should have_many :items
end
