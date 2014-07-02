module SimpleAuthorize
  extend ActiveSupport::Concern

  def authorize(resource)
    unless send(:"#{resource}_signed_in?")
      redirect_to root_path
    end
  end

  private :authorize

  module ClassMethods
    def authorize resource, opts={}
      before_action(opts) do |controller|
        controller.send(:authorize, resource)
      end
    end
  end
end