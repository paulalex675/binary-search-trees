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
  attr_accessor :root, :value, :leaf_nodes, :temp_queue

  def initialize(ary)
      @value = merge_sort(ary)
      @root = build_tree(@value)
      @leaf_nodes = Array.new
      @temp_queue = Array.new
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

  def delete(value)
    to_del = find(value)
    parent = find_parent(value)
    if parent.left == to_del
      if parent.left.left == nil && parent.left.right == nil
        parent.left = nil
      elsif parent.left.left != nil && parent.left.right == nil
        parent.left = parent.left.left
        parent.left.left = nil
      elsif parent.left.left != nil && parent.left.right != nil
        parent.left = parent.left.right
      else
        puts "still working on that" 
      end
    elsif parent.right == to_del
      if parent.right.right == nil && parent.right.left == nil
        parent.right = nil
      elsif parent.right.right != nil && parent.right.left == nil
        parent.right = parent.right.right
        parent.right.right = nil
      elsif parent.right.right != nil && parent.right.left != nil
        parent.right = parent.right.left
      else puts "still workingon that"
      end
    end
    @leaf_nodes.delete(to_del)
    @value.delete(to_del.data)
  end

  def find_parent(value, node = self.root)
    if value == node.data
      return "#{node.data} is an orphan, it has no parent nodes"
    elsif value == node.left.data
       return parent = node
    elsif value == node.right.data
      return parent = node
    elsif value < node.data
      find_parent(value, node.left)
    else value > node.data
      find_parent(value, node.right)
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

  def level_order(node = self.root)
    if node != nil
      @temp_queue << node.data
      level_order(node.left)
      level_order(node.right)
    end
    return @temp_queue
  end

  def inorder

  end

  def preorder

  end

  def postorder

  end

  def height
  
  end

  def depth(value)

  end

  def balanced?(counter = 0, node = self.root)

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