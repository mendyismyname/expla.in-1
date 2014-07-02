module SimpleAuthenticate
  extend ActiveSupport::Concern

  module ClassMethods
    def authenticate resource
      SimpleAuthenticate.define_helpers(self, resource)
    end
  end

  module_function

    def method_map resource
      {
        :"current_#{resource}" => lambda do
          instance_eval <<-code
            id = session[:#{resource}_id]
            @current_#{resource} ||=  id && #{resource.to_s.classify}.find_by_id(id)
          code
        end,
        :"#{resource}_signed_in?" => lambda do
          instance_eval <<-code
            !!current_#{resource}
          code
        end
      }
    end

    def define_helpers klass, resource
      SimpleAuthenticate.method_map(resource).each do |name, lamb|
        klass.send(:define_method, name, &lamb)
      end
    end


end