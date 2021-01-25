class Node
  include Comparable
    attr_accessor :left, :right, :data, :leaf_node
    
    def initialize(data, left = nil, right = nil)
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
      @root = Node.new(array[0])
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
        node.left = Node.new(value)
      else insert(value, node.left)
      end
    else
      if node.right == nil
        node.right = Node.new(value)
      else insert(value, node.right)
      end
    end
  end

  def delete(value, node = self.root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # if node has one or no child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # if node has two children
      leftmost_node = find_replacement(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
    @leaf_nodes.delete(node)
    @value.delete(value)
    puts node
  end

  def find_replacement(node = self.root)
    if node.left == nil && node.right == nil
      return node 
    else find_replacement(node.left)
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

  def level_order(node = self.root, queue = [])
    print "#{node.data} "
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return if queue.empty?

    level_order(queue.shift, queue)
  end

  def inorder(node = self.root)
    return node if node.nil?

    inorder(node.left)
    print "#{node.data} "
    inorder(node.left)
  end

  def preorder(node = self.root)
    return node if node.nil?
    print "#{node.data} "
    preorder(node.left)
    preorder(node.right)

  end

  def postorder(node = self.root)
    return node if node.nil?

    postorder(node.left) 
    postorder(node.right) 
    print "#{node.data} "
  end

  def depth(value, node = self.root, x = 0)
    if node.data == value
      puts x
    else
      value < node.data ? depth(value, node.left, x += 1) : depth(value, node.right, x += 1)
    end
  end

  def height(value, node = find(value), x = 0)
    return node if node.nil?
    if node.left == nil && node.right == nil
      return x
    elsif node.left == nil && node.right != nil
      height(value, node.right, x += 1)
    else
      height(value, node.left, x += 1)
    end    
  end

  def balanced?
    value = self.root.data
    z = height(value, self.root.left)
    y = height(value, self.root.right)
    x = z >= y ? z - y : y - z
    x <= 1 ? true : false   
  end

  def rebalance
    merge_sort(gather)
  end

  def gather(node = self.root, gath_arr = [])
    if node != nil
      gath_arr << node.data
      gather(node.left)
      gather(node.right)
      return gath_arr
    end
  end

  def leaf_node(value)
    node = find(value)
    if node.left == nil && node.right == nil
        return node
    else
      puts "#{node.data} is not a leaf node"
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