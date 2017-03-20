require 'caracal/core/models/field_model'


module Caracal
  module Core
    
    # This module encapsulates all the functionality related to adding page
    # breaks to the document.
    #
    module Fields
      def self.included(base)
        base.class_eval do
          
          #-------------------------------------------------------------
          # Public Methods
          #-------------------------------------------------------------
          
          def field(arg=nil)
            model = Caracal::Core::Models::FieldModel.new()
            model.field_type = arg
            contents << model
            model
          end
          
        end
      end
    end
    
  end
end