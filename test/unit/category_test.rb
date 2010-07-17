require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CategoryTest < ActiveSupport::TestCase
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
    categories[1].sub_categories << categories[4]
    
    should = [[ categories[0], categories[1], categories[4] ]]
    assert_equal should, categories.last.get_breadcrumbs    
  end
  
  test "Simple find top categories" do
    category = TestFactory.create_category
    top_categories = Category.find_toplevel_categories
    
    assert !(top_categories & [ category ]).empty?, "Simple Top Category not found"
  end
  
  test "Find top categories" do
    # c0   c1   c2
    #  \  /    /
    #   c3    /
    #    \   /
    #     c4
    
    categories = TestFactory.create_categories 5
    categories[3].super_categories = categories[0..1]
    categories[4].super_categories = categories[2..3]
    top_categories = Category.find_toplevel_categories

    should = categories[0..2]
    should_not = categories[3..4]
    
    assert (should - top_categories).empty?, "Too less Toplevels found:\n#{categories.inspect}, but expected\n#{should.inspect}"
    assert (should_not & top_categories).empty?, "Too many Toplevels found:\n#{categories.inspect}, but expected\n#{should.inspect}, intersect:\n#{(categories & categories[3..4]).inspect}"
  end
  
  test "Check ancestors chaining" do
    categories = TestFactory.create_categories 5
    categories.each_index do |i|
      categories[i - 1].sub_categories = [ categories[i] ] if i > 0
    end
    
    assert categories[0].ancestor_of?(categories[1]), "Direct ancestorship failed"
    assert categories[0].ancestor_of?(categories[2]), "Ancestorship over 1 generation failed"
    assert categories[0].ancestor_of?(categories[4]), "Ancestorship over 3 generation failed"
  end
  
  test "Check ancestors simple" do
    categories = TestFactory.create_categories 2
    
    assert !categories[0].ancestor_of?(categories[1])
    assert !categories[1].ancestor_of?(categories[0])
    assert !categories[0].descendant_of?(categories[1])
    assert !categories[1].descendant_of?(categories[0])
    assert !categories[1].descendant_of?(categories[1])
  end
  
  test "Check ancestors tree" do
    # c0   c1   c2
    #  \  /    /
    #   c3    /
    #    \   /
    #     c4
    
    categories = TestFactory.create_categories 5
    categories[3].super_categories = categories[0..1]
    categories[4].super_categories = categories[2..3]

    assert !categories[3].ancestor_of?(categories[1]), "Direct Ancestorship generation failed"
    assert categories[2].ancestor_of?(categories[4]), "Direct Ancestorship generation failed"
    assert categories[0].ancestor_of?(categories[4]), "Ancestorship over 1 generation failed"
    assert categories[1].ancestor_of?(categories[4]), "Ancestorship over 1 generation failed"
  end
  
  test "Supercategory cache invalidation" do
    # c0   c1   c2
    #  \  /    /
    #   c3    /
    #    \   /
    #     c4
    
    categories = TestFactory.create_categories 2
    categories.each { |c| c.super_categories }
    categories[0].sub_categories = [ categories[1] ]
    assert_equal [ categories[0] ], categories[1].super_categories 
  end
  test "Subcategory cache invalidation" do
    # c0   c1   c2
    #  \  /    /
    #   c3    /
    #    \   /
    #     c4
    
    categories = TestFactory.create_categories 2
    categories.each { |c| c.sub_categories }
    categories[0].super_categories = [ categories[1] ]
    assert_equal [ categories[0] ], categories[1].sub_categories 
  end
end
