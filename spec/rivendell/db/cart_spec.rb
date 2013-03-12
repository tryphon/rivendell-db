require 'spec_helper'

describe Rivendell::DB::Cart do

  let(:group) { Rivendell::DB::Group.create :name => "Dummy", :default_cart_range => 1..10 }

  describe ".duplicated!" do
    
    it "should return Carts " do
      original = group.carts.create :title => "Example 1", :artist => "First Artist"
      group.carts.create :title => "Example 2", :artist => "First Artist"
      group.carts.create :title => "Example 1", :artist => "Second Artist"
      duplicate = group.carts.create :title => "Example 1", :artist => "First Artist"

      Rivendell::DB::Cart.duplicated(:title, :artist).should == [{
        :numbers => [original, duplicate].map(&:number),
        :fields => { :title => original.title, :artist => original.artist }
      }]
    end

  end

end
