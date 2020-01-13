require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :max, :prc, :store, :map

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if map[key]
      node = map[key]
      puts "node to be moved --> k: #{node.key} --- v: #{node.val}\n"
      update_node!(node)
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  # attr_reader :store, :map

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = self.prc.call(key)
    new_node = store.append(key, val)
    self.map[key] = new_node 

    eject! if self.max < count
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    self.map[node.key] = self.store.append(node.key, node.val)
  end

  def eject!
    to_be_removed_node = self.store.first
    to_be_removed_node.remove
    self.map.delete(to_be_removed_node.key)
    nil
  end
end

# squared_val_prc = Proc.new { |x| x ** 2 }
# lru = LRUCache.new(4, squared_val_prc)
# lru.get(2)
# lru.get(3)
# lru.get(4)
# lru.get(2)
# lru.get(5)

# puts lru.to_s