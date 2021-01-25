require_relative 'binary_search_trees.rb'

test = [69, 1, 2, 3, 4, 45, 6, 7, 8, 9, 10, 6, 2, 34, 17, 90, 99, 101, 105, 160, 57, 900]
tree1 = BinaryTree.new(test)
pp tree1
puts tree1.postorder
tree1.rebalance
