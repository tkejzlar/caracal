require 'caracal/core/models/base_model'


module Caracal
  module Core
    module Models

      # This class handles block options passed to the page size
      # method.
      #
      class DocumentSettingsModel < BaseModel

        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------

        # accessors
        attr_reader :document_id
        attr_reader :document_name
        attr_reader :document_version
        attr_reader :document_doctype
        attr_reader :document_cover

        # initialization
        def initialize(options={}, &block)
          super options, &block
        end


        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------

        #=============== SETTERS ==============================

        def id(value)
          @document_id = value.to_s
        end
        
        def name(value)
          @document_name = value.to_s
        end
        
        def version(value)
          @document_version = value.to_s
        end
        
        def doctype(value)
          @document_doctype = value.to_s
        end
        
        def cover(value)
          @document_cover = !!value
        end


        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private

        def option_keys
          [:id, :name, :version, :doctype, :cover]
        end

      end

    end
  end
end
