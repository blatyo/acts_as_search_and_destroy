module ActsAsSearchAndDestroy
  class Index
    OPTIONS = [:api_url, :index, :id_postfix, :text, :other_fields, :categorize_by, :age]
    attr_accessor *OPTIONS
  
    def initialize(klass, options)
      @klass = klass
      options = default_options.merge(options)
      OPTIONS.each do |attribute|
        self.send(:"#{attribute}=", options[attribute])
      end
    end
  
    def search(query, category_filters)
      results = index.search(query, category_filters)
      ids = JsonPath.new('$..docid').on(results).map(&:to_i)
      @klass.where(:id => ids)
    end
  
    def index_new_or_updated(indexable)
      document = index.document(doc_id(indexable))
      document.add(doc(indexable))
      document.update_categories(categorizations(indexable))
    end
  
    def unindex_destroyed(indexable)
      index.document(doc_id(indexable)).delete
    end
  
  private

    def doc_id(indexable)
      "#{indexable.id}#{id_postfix}"
    end

    def doc(indexable)
      doc = Hash[other_fields.collect{|field| [field, indexable.send(field)]}]
      doc[:text] = indexable.send(text)
      doc[:timestamp] = indexable.send(age).to_time.to_i
      doc
    end
  
    def categorizations(indexable)
      Hash[categorize_by.collect{|categorization| [categorization, indexable.send(categorization)]}]
    end
  
    def index
      @index ||= api.indexes(@index)
    end
  
    def api
      @api ||= IndexTank::Client.new(api_url)
    end
  
    def default_options
      {
        :api_url => @@api_url,
        :id_prefix => @klass.name.pluralize,
        :index => @klass.name.pluralize,
        :text => :text,
        :other_fields => [],
        :categorize_by => [],
        :age => :created_at
      }
    end
  end
end