module YoolkApi
  module Resource::HasManyMethods
    extend ActiveSupport::Concern

    included do
      def klass_for_association(options)
        klass_name = options[:class_name]
        raise "Missing class name of associated model. Provide with class_name: 'MyClass'." unless klass_name.present?
        return self.class.klass_from_string(klass_name)
      end
    end

    module ClassMethods
      def has_many(association_name, options={})
        define_method(association_name) do
          association_klass   = klass_for_association(options)
          association_path    = options[:api_path] || "/#{resource_name}/#{identity}/#{association_name}"
          resource_collection = instance_variable_get("@#{association_name}_resource_collection")

          if resource_collection.nil?
            resource_collection = Resource::Collection.new(association_klass, association_path)
            resource_collection.set_response(attributes[association_name])
            instance_variable_set("@#{association_name}_resource_collection", resource_collection)
          else
            resource_collection.reset_query
          end
          resource_collection
        end

        define_method("#{association_name}?") do
          send(association_name).length > 0
        end
      end
    end
  end
end