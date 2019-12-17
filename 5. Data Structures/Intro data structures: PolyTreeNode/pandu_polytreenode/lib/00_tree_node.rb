class PolyTreeNode
    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def value
        @value
    end

    def inspect
        # return nil if @parent.value == nil || @parent.value.empty?
        # { parent: @parent.value, children: @children, child_name: @value }.inspect
        # @value.inspect
        { value: @value, parent_value: @parent.value }.inspect
    end

    def parent=(parent)
        # avoid adding the same node/parent twice
        return if self.parent == parent

        # Detach the old parent first
        if self.parent
            self.parent.children.delete(self)
        end

        @parent = parent
        self.parent.children.push(self) unless self.parent.nil?
        self
    end

    def add_child(child)
        # "(one of) isa parent is gerard (!!!)"
        child.parent = self
    end

    def remove_child(child)
        # "Lizbeth is not Gerard's daughter"
        if child && !self.children.include?(child)
            raise "#{child.value} is not #{self.value}'s child to begin with..."
        end

        # "wait, turns out gerard actually not (isa's parent)?"
        child.parent = nil

        # "So who is Isa's father?"
    end

    def dfs(target)
        return nil if self.nil?
        return self if self.value == target

        self.children.each do |child|
            deep_search = child.dfs(target)
            return deep_search unless deep_search.nil?
        end
        nil
    end

    def bfs(target)
        queue = [self]
        until queue.length == 0
            current_node = queue.shift
            return current_node if current_node.value == target
            queue.concat(current_node.children)
        end
        nil
    end

end

gerard = PolyTreeNode.new("Gerard")
lucas = PolyTreeNode.new("Lucas")
selene = PolyTreeNode.new("Selene")

jody = PolyTreeNode.new("Jody")
lucille = PolyTreeNode.new("Lucille")

lizbeth = PolyTreeNode.new("Lizbeth")
daryl = PolyTreeNode.new("Daryl")

isa = PolyTreeNode.new("Isabelle")
don = PolyTreeNode.new("Donatello")

# connect the bloodline(?)
gerard.add_child(lucas)
gerard.add_child(selene)

lucas.add_child(jody)

jody.add_child(lucille)

selene.add_child(lizbeth)
selene.add_child(daryl)

lizbeth.add_child(isa)
lizbeth.add_child(don)

# p selene

# # this should work
# raise "Bad parent=!" unless isa.parent == lizbeth
# raise "Bad parent=!" unless lizbeth.children == [isa]

# # this probably doesn't
# raise "Bad parent=!" unless gerard.children == []


# p gerard.children
# p selene.bfs(daryl)