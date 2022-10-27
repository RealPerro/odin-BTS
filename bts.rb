class Node
  attr_accessor :data, :left, :right
  def initialize(datapoint = nil, left_child = nil, right_child = nil)
    @data = datapoint
    @left = left_child
    @right = right_child
  end

  def to_s
    left = @left.nil? ? "nil" : "#{@left.data}"
    right = @right.nil? ? "nil" : "#{@right.data}"
    out = "node: data = #{@data}, left = #{left}, right = #{right}" 
  end
end

class Tree
  attr_accessor :arr, :root
  def initialize(arr)
    @arr = arr.is_a?(Array) ? arr.uniq.sort : "not an array"
    @root = build_tree(@arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def build_tree(arr)
    return Node.new(arr.first,nil, nil) if arr.length == 1
    return Node.new(arr.first, Node.new(arr[1], nil, nil), nil) if arr.length == 2 && arr[1] < arr[0]
    return Node.new(arr.first, nil,  Node.new(arr[1], nil, nil)) if arr.length == 2 && arr[1] > arr[0]

    mid = arr.length.div(2)
    my_node = Node.new(arr[mid], build_tree(arr[0...mid]), build_tree(arr[mid+1..-1]))
    return my_node
  end

  def find(value, node = @root)
    return node if node.nil? || node.data == value
    value < node.data ? find(value, node.left) : find(value, node.right)
  end

end

my_tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
my_tree.pretty_print

p "testing find"
p my_tree.find(8).to_s
p my_tree.find(4).to_s
p my_tree.find(3).to_s
p my_tree.find(324).to_s
p my_tree.find(2).to_s
