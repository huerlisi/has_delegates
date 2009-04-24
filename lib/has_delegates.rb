# HasDelegates
module HasDelegates
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def belongs_to_delegate(delegate_id, options = {})
      delegate_to(:belongs_to, delegate_id, options)
    end

    def has_one_delegate(delegate_id, options = {})
      delegate_to(:has_one, delegate_id, options)
    end

    private

    def delegate_to(macro, delegate_id, options = {})
      send macro, delegate_id, options

      save_callback = {:belongs_to => :before_save, :has_one => :after_save}[macro]

      send save_callback do |model|
        model.send(delegate_id).save
      end

      delegate_names = respond_to?('safe_delegate_names') ? safe_delegate_names : []
      delegate_names = (delegate_names - [delegate_id]) + [delegate_id]

      def_string, source_file, source_line = <<-"end_eval", __FILE__, __LINE__

        def self.safe_delegate_names
          #{delegate_names.inspect}
        end

        def safe_delegates
          self.class.safe_delegate_names.collect do |delegate_name|
            send(delegate_name).nil? ? send("build_\#{delegate_name}") : send(delegate_name)
          end
        end

        def method_missing(method_id, *args)
          safe_delegates.each do |delegate|
            return delegate.send(method_id, *args) if delegate.respond_to?(method_id)
          end
          super
        end

        def respond_to?(*args)
          safe_delegates.any? {|delegate| delegate.respond_to?(*args)} || super
        end

      end_eval

      module_eval def_string, source_file, source_line + 1
    end
  end
end
