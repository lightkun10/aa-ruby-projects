class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{self.key}: #{self.val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end


class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Node.new("Original head")
    @tail = Node.new("Original tail")
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    if empty?
      nil
    else
      self.head.next
    end
  end

  def last
    if empty?
      nil
    else
      self.tail.prev
    end
  end

  def empty?
    self.head.next == self.tail
  end

  def get(key)
  end

  def include?(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)

    self.tail.prev.next = new_node
    new_node.next = self.tail
    new_node.prev = self.tail.prev
    self.tail.prev = new_node

    new_node
  end

  def update(key, val)
  end

  def remove(key)
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end


ll = LinkedList.new
ll.append(:first, 1)

p ll