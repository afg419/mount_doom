require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "an category type category can be created with valid attributes" do
    category = Category.new(name: "Lard")

    assert category.valid?
    assert_equal "Lard", category.name
  end

  test "an category type category can not be created without a name" do
    category = Category.new

    assert category.invalid?
  end
end
