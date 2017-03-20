require 'nokogiri'

require 'caracal/renderers/xml_renderer'


module Caracal
  module Renderers
    class HeaderRenderer < XmlRenderer
      
      #-------------------------------------------------------------
      # Public Methods
      #-------------------------------------------------------------
      
      # This method produces the xml required for the `word/settings.xml` 
      # sub-document. 
      #
      def to_xml
        builder = ::Nokogiri::XML::Builder.with(declaration_xml) do |xml|
          xml.send 'w:hdr', root_options do
            xml.send 'w:tbl' do
              xml.send 'w:tblPr' do
                xml.send 'w:tblW', { 'w:w' => 5000, 'w:type' => 'pct'}
              end
              xml.send 'w:tr' do
                xml.send 'w:tc' do
                  xml.send 'w:p' do
                    xml.send 'w:pPr' do
                      xml.send 'w:jc', { 'w:val' => 'left' }
                      xml.send 'w:spacing', { 'w:before' => 0, 'w:after' => 0, 'w:line' => 300, 'w:lineRule' => 'auto' }
                    end
                    xml.send 'w:r' do
                      xml.send 'w:t', "#{document.document_doctype} for #{document.document_name}"
                    end
                  end
                end
                xml.send 'w:tc' do
                  xml.send 'w:p' do
                    xml.send 'w:pPr' do
                      xml.send 'w:jc', { 'w:val' => 'right' }
                      xml.send 'w:spacing', { 'w:before' => 0, 'w:after' => 0, 'w:line' => 300, 'w:lineRule' => 'auto' }
                    end
                    xml.send 'w:r' do
                      xml.send 'w:t', "Proprietary"
                    end
                  end
                end
              end
            end
          end
        end
        builder.to_xml(save_options)
      end
      
      
      #-------------------------------------------------------------
      # Private Methods
      #------------------------------------------------------------- 
      private
      
      def root_options
        {
          #'xmlns:mc'  => 'http://schemas.openxmlformats.org/markup-compatibility/2006',
          #'xmlns:o'   => 'urn:schemas-microsoft-com:office:office',
          #'xmlns:r'   => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
          #'xmlns:m'   => 'http://schemas.openxmlformats.org/officeDocument/2006/math',
          #'xmlns:v'   => 'urn:schemas-microsoft-com:vml',
          #'xmlns:wp'  => 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing',
          #'xmlns:w10' => 'urn:schemas-microsoft-com:office:word',
          #'xmlns:w'   => 'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
          #'xmlns:wne' => 'http://schemas.microsoft.com/office/word/2006/wordml',
          #'xmlns:sl'  => 'http://schemas.openxmlformats.org/schemaLibrary/2006/main',
          #'xmlns:a'   => 'http://schemas.openxmlformats.org/drawingml/2006/main',
          #'xmlns:pic' => 'http://schemas.openxmlformats.org/drawingml/2006/picture',
          #'xmlns:c'   => 'http://schemas.openxmlformats.org/drawingml/2006/chart',
          #'xmlns:lc'  => 'http://schemas.openxmlformats.org/drawingml/2006/lockedCanvas',
          #'xmlns:dgm' => 'http://schemas.openxmlformats.org/drawingml/2006/diagram'
          'xmlns:wpc' => "http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas",
          'xmlns:mo' => "http://schemas.microsoft.com/office/mac/office/2008/main",
          'xmlns:mc' => "http://schemas.openxmlformats.org/markup-compatibility/2006", 
          'xmlns:mv' => "urn:schemas-microsoft-com:mac:vml",
          'xmlns:o' => "urn:schemas-microsoft-com:office:office", 
          'xmlns:r' => "http://schemas.openxmlformats.org/officeDocument/2006/relationships", 
          'xmlns:m' => "http://schemas.openxmlformats.org/officeDocument/2006/math", 
          'xmlns:v' => "urn:schemas-microsoft-com:vml", 
          'xmlns:wp14' => "http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing", 
          'xmlns:wp' => "http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing", 
          'xmlns:w10' => "urn:schemas-microsoft-com:office:word", 
          'xmlns:w' => "http://schemas.openxmlformats.org/wordprocessingml/2006/main", 
          'xmlns:w14' => "http://schemas.microsoft.com/office/word/2010/wordml", 
          'xmlns:w15' => "http://schemas.microsoft.com/office/word/2012/wordml", 
          'xmlns:wpg' => "http://schemas.microsoft.com/office/word/2010/wordprocessingGroup", 
          'xmlns:wpi' => "http://schemas.microsoft.com/office/word/2010/wordprocessingInk", 
          'xmlns:wne' => "http://schemas.microsoft.com/office/word/2006/wordml", 
          'xmlns:wps' => "http://schemas.microsoft.com/office/word/2010/wordprocessingShape"   
        }
      end
   
    end
  end
end