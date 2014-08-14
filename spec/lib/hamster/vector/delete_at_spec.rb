require "spec_helper"
require "hamster/vector"

describe Hamster::Vector do
  describe "#delete_at" do
    before do
      @vector = Hamster.vector(1,2,3,4,5)
    end

    it "removes the element at the specified index" do
      @vector.delete_at(0).should eql(Hamster.vector(2,3,4,5))
      @vector.delete_at(2).should eql(Hamster.vector(1,2,4,5))
      @vector.delete_at(-1).should eql(Hamster.vector(1,2,3,4))
    end

    it "makes no modification if the index is out of range" do
      @vector.delete_at(5).should eql(@vector)
      @vector.delete_at(-6).should eql(@vector)
    end

    it "works when deleting last item at boundary where vector trie needs to get shallower" do
      vector = Hamster::Vector.new(1..33)
      vector.delete_at(32).size.should == 32
      vector.delete_at(32).to_a.should eql((1..32).to_a)
    end

    it "has the right size and contents after many deletions" do
      array  = (1..2000).to_a # we use an Array as standard of correctness
      vector = Hamster::Vector.new(array)
      500.times do
        index = rand(vector.size)
        vector = vector.delete_at(index)
        array.delete_at(index)
        vector.size.should == array.size
        ary = vector.to_a
        ary.size.should == vector.size
        ary.should eql(array)
      end
    end
  end
end