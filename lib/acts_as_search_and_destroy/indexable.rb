module ActsAsSearchAndDestroy
  module Indexable
    extend ActiveSupport::Concern
  
    included do
      after_save :index_new_or_updated
      after_destroy :unindex_destroyed 
    end
  
    module ClassMethods
      def search(*args)
        @@index.search(*args)
      end
    end
  
    module InstanceMethods
      def index_new_or_updated
        @@index.index_new_or_updated(self)
      end
    
      def unindex_destroyed
        @@index.unindex_destroyed(self)
      end
    end
  end
end