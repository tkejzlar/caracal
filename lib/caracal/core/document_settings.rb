require 'caracal/core/models/document_settings_model'
require 'caracal/errors'


module Caracal
  module Core

    # This module encapsulates all the functionality related to setting the
    # document's size and margins.
    #
    module DocumentSettings
      def self.included(base)
        base.class_eval do

          #-------------------------------------------------------------
          # Configuration
          #-------------------------------------------------------------

          # accessors
          attr_reader :document_name
          attr_reader :document_id
          attr_reader :document_version
          attr_reader :document_doctype
          attr_reader :document_cover


          #-------------------------------------------------------------
          # Public Methods
          #-------------------------------------------------------------

          # This controls global settings for the document (id, name, version) that can
          # be printed in headers and footers
          #
          def document_settings(options={}, &block)
            model = Caracal::Core::Models::DocumentSettingsModel.new(options, &block)
            
            if model.valid?
              @document_id       = model.document_id
              @document_name     = model.document_name
              @document_version  = model.document_version
              @document_doctype  = model.document_doctype
              @document_cover    = model.document_cover
            else
              raise Caracal::Errors::InvalidModelError, 'page_size method requires non-zero :width and :height options.'
            end
          end

        end
      end
    end

  end
end
