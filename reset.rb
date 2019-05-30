class Reset

  def initialize(list = nil)
    @reset ||= Hash.new
    if list
      list.each do |el|
        @reset[el] = true
      end
    end
    return @reset
  end

  def union(reset)
    temp = {}
    original = self.hash_value
    another = reset.hash_value
    if original.empty?
      return reset
    elsif another.empty?
      return self
    end
    another.each do |elem1, val1|
      original.each do |elem2, val2|
        temp[elem1] = val1 if !temp.key?(elem1)
        temp[elem2] = val2 if !temp.key?(elem2)
      end
    end
    self.class.new(temp.keys)
  end

  alias + union

  def intersection(reset)
    temp = {}
    original = self.hash_value
    another = reset.hash_value
    original.each do |elem, val|
      temp[elem] = val if another.key?(elem)
    end
    return self.class.new(temp.keys)
  end

  alias & intersection

  def difference(reset)
    temp = {}
    original = self.hash_value
    another = reset.hash_value
    original.each do |elem, val|
      temp[elem] = val if !another.key?(elem)
    end
    return self.class.new(temp.keys)
  end

  alias - difference

  def subset?(reset)
    temp = true
    subset = self.hash_value
    universe = reset.hash_value
    subset.each do |elem, val|
      temp = false if !universe.key?(elem)
    end
    return temp
  end

  alias sub? subset?

  def hash_value
    @reset
  end

  def inspect
    "#<#{self.class.name}: {#{@reset.keys.inspect[1..-2]}}>"
  end

end
