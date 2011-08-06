require 'spec_helper'

describe ActsAsSearchAndDestroy do
  describe ".acts_as_search_and_destroy" do
    class BadJoke < ActiveRecord::Base
      acts_as_search_and_destroy
    end
    
    subject{BadJoke}
    it{should be_a(ActsAsSearchAndDestroy::Indexable)}
    it{should respond_to(:search)}
    
    subject{BadJoke.new}
    it{should respond_to(:index_new_or_updated)}
    it{should respond_to(:unindex_destroyed)}
  end
end