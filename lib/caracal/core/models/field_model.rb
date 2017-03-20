require 'caracal/core/models/base_model'


module Caracal
  module Core
    module Models
      
      # This class encapsulates the logic needed to store and manipulate
      # line break data.
      #
      class FieldModel < BaseModel 
      
        attr_accessor :field_type
        
      end
      
    end
  end
end