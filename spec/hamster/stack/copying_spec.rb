require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Hamster::Stack do

  [:dup, :clone].each do |method|

    [
      [],
      ["A"],
      ["A", "B", "C"],
    ].each do |values|

      describe "on #{values.inspect}" do

        stack = Hamster.stack(*values)

        it "returns self" do
          stack.send(method).should equal(stack)
        end

      end

    end

  end

end
