require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "breadcrumps simple" do
    category = TestFactory.create_category
    assert_equal [[ category ]], category.get_breadcrumbs
  end
  
  test "breadcrumbs chain" do
    categories = TestFactory.create_categories 5
    categories.each_index do |i|
      categories[i - 1].sub_categories = [ categories[i] ] if i > 0
    end
    
    assert_equal [ categories ], categories.last.get_breadcrumbs
  end

  test "breadcrumbs tree" do
    # c0   c1   c2
    #  \  /    /
    #   c3    /
    #    \   /
    #     c4
    
    categories = TestFactory.create_categories 5
    categories[3].super_categories = categories[0..1]
    categories[4].super_categories = categories[2..3]

    should = [ 
      [ categories[2], categories[4] ],
      [ categories[0], categories[3], categories[4] ],
      [ categories[1], categories[3], categories[4] ]
    ]

    assert_equal should.sort, categories.last.get_breadcrumbs.sort
  end
  
  test "many subcategories" do
    #       c0
    #     c1 c2 c3
    #    c4
    categories = TestFactory.create_categories 5
    categories[0].sub_categories = categories[1..3]
    categories[1].sub_categories = [ categories[4] ]
    
    should = [[ categories[0], categories[1], categories[4] ]]
    assert_equal should, categories.last.get_breadcrumbs    
  end
end
