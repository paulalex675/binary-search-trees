class Node
    attr_accessor :left, :right, :data
    
    def initialize(data, left, right)
        @data = data
        @left = left
        @right = right
    end
end

class BinaryTree
    attr_accessor :root, :value

    def initialize(ary)
        @value = merge_sort(ary)
        @root = build_tree(ary)
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
      if array.length <= 1
        @root = Node.new(array[0], nil, nil)
      elsif array.length > 1 && array.length < 3
        @root = Node.new(array[1], Node.new(array[0], nil, nil), nil)
      else
        mid = array.length/2
        @root = Node.new(array[mid], build_tree(array.slice(0..mid)), build_tree(array.slice(mid...-1)))
      end
    end

    def insert(value)

    end

    def delete(value)

    end

    def find(value)

    end

    def level_order(value)

    end

    def inorder

    end

    def preorder

    end

    def postorder

    end

    def height(value)

    end

    def depth(value)

    end

    def balanced?

    end

    def rebalance

    end

end

test = [1, 2, 3, 4, 5, 6, 7, 8, 9]
tree1 = BinaryTree.new(test)
pp tree1