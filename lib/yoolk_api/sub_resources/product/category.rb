module YoolkApi
  class Product::Category < SubResource
    attr_reader :products
    
    def initialize(attributes={}, products=[])
      super(attributes)
      @products = products
    end
  end
end