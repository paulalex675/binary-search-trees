require_relative 'binary_search_trees.rb'

test = [69, 1, 2, 3, 4, 45, 6, 7, 8, 9, 10, 6, 2, 34, 17, 90, 99, 101, 105, 160, 57, 900]
tree1 = BinaryTree.new(test)
#tree1 = BinaryTree.new(Array.new(25) { rand(1..100) })
#pp tree1
puts tree1.find(4)
#puts tree1.insert(5)
pp tree1
tree1.how_many_leaves?
#tree1.leaf_node(10)
#puts tree1.find(7).data
#puts tree1.find_parent(8)
tree1.delete(900)
pp tree1
p tree1.level_order()