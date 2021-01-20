class Node
  include Comparable
    attr_accessor :left, :right, :data, :leaf_node
    
    def initialize(data, left, right)
        @data = data
        @left = left
        @right = right
    end
end

class BinaryTree
    attr_accessor :root, :value, :leaf_nodes

    def initialize(ary)
        @value = merge_sort(ary)
        @root = build_tree(@value)
        @leaf_nodes = Array.new
        leaf_node_count
        depth_counter = 0
        height_counter  = 0
    end
    
    def merge_sort(array)
        array.uniq!
        if array.length <= 1
            array
        else
          mid = array.length/2
          first_half = merge_sort(array.slice(0...mid))
          second_half = merge_sort(array.slice(mid...array.length))
          mergeS(first_half, second_half)
        end
    end
      
    def mergeS(first_array, second_array)
      sorted_array = []
      while !first_array.empty? && !second_array.empty? do
        if first_array[0] < second_array[0]
        sorted_array << first_array.shift
        else
        sorted_array << second_array.shift
        end
      end
      return sorted_array.concat(first_array).concat(second_array)
    end

    def build_tree(array)
      return nil if array.empty?

      if array.length <= 1
        @root = Node.new(array[0], nil, nil)
      else
        mid = array.length/2
        @root = Node.new(array[mid], build_tree(array.slice(0...mid)), build_tree(array.slice(mid+1..array.length)))
      end
    end

    def insert(value, node = self.root)
      if value == node.data
        return 'That node already exists'
      elsif value < node.data
        if node.left == nil
          node.left = Node.new(value, nil, nil)
        else insert(value, node.left)
        end
      else
        if node.right == nil
          node.right = Node.new(value, nil, nil)
        else insert(value, node.right)
        end
      end
    end

    def delete(value, node = self.root)
      if node == nil
        return "Looked for #{value} but no match found"
      elsif node.left == nil && node.right == nil
        node = nil
      elsif value < node
        delete(value, node.left)
      elsif value > node
        delete(value, node.right)
      else
      end
    end

    def find(value, node = self.root)
      if node == nil
        return "Looked for #{value} but no match found"
      elsif value == node.data
        return node
      elsif value < node.data
        find(value, node.left)
      elsif value > node.data
        find(value, node.right)
      else
        return "Looked for #{value} but no match found"
      end
    end

    def level_order(value)

    end

    def inorder

    end

    def preorder

    end

    def postorder

    end

    def calculate_LH(value)
      node = find(value)
      if node.left == nil
        counter_l += 1
      else
        calculate_LH(node.left) 
        counter_l += 1
      end
    end

    def calculate_RH(value)
      node = find(value)
      if node.right == nil
        counter_r += 1
      else 
        calculate_RH(node.right)
        counter_r += 1
      end
    end

    def height(value)
      counter_r = 0
      counter_l = 0
      calculate_LH(value)
      calculate_RH(value)
      if counter_l < counter_r
         puts counter_r 
      else 
        puts counter_l
      end
    end

    def depth(value)

    end

    def balanced?

    end

    def rebalance

    end

    def leaf_node(value)
      node = find(value)
      if node.left == nil && node.right == nil
         puts "#{value} is a leaf node" 
      else
        puts "#{value} is not a leaf node"
      end
    end

    def leaf_node_count(node = self.root)
      if node.left == nil && node.right == nil
        leaf_nodes << node
      elsif node.left != nil && node.right != nil
        leaf_node_count(node.left)
        leaf_node_count(node.right)
      elsif node.left != nil && node.right == nil
        leaf_node_count(node.left)
      else node.left == nil && node.right != nil
        leaf_node_count(node.right)        
      end
    end

    def how_many_leaves?
      puts "There are #{leaf_nodes.length} leaf nodes in this tree"
    end

end

test = [1, 2, 3, 4, 45, 6, 7, 8, 9, 10, 6, 2, 34, 17]
tree1 = BinaryTree.new(test)
#tree1 = BinaryTree.new(Array.new(15) { rand(1..100) })
#pp tree1
#puts tree1.find(4)
#puts tree1.insert(5)
pp tree1
tree1.how_many_leaves?
tree1.leaf_node(10)
print tree1.height(7)