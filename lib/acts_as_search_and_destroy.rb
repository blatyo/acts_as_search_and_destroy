path = File.expand_path(File.dirname(__FILE__)) + '/acts_as_search_and_destroy'
require 'active_support'
require 'active_record'
require 'indextank'
require "#{path}/index"
require "#{path}/indexable"

module ActsAsSearchAndDestroy
  extend ActiveSupport::Concern
  
  module ClassMethods
    def acts_as_search_and_destroy(options)
      self.send :include, Indexable
      @@index = Index.new(self, options)
    end
  end
end
ActiveRecord::Base.send :include, ActsAsSearchAndDestroy
