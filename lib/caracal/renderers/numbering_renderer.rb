require 'nokogiri'

require 'caracal/core/models/list_style_model'
require 'caracal/core/models/list_model'
require 'caracal/renderers/xml_renderer'


module Caracal
  module Renderers
    class NumberingRenderer < XmlRenderer
      
      #-------------------------------------------------------------
      # Public Methods
      #-------------------------------------------------------------
      
      # This method produces the xml required for the `word/numbering.xml` 
      # sub-document.
      #
      def to_xml
        builder = ::Nokogiri::XML::Builder.with(declaration_xml) do |xml|
          xml.send 'w:numbering', root_options do
            
            # heading numbering
            texts = ['%1.', '%1.%2.', '%1.%2.%3.', '%1.%2.%3.%4.', '%1.%2.%3.%4.%5.', '%1.%2.%3.%4.%5.%6.'] 
            indents = [360, 360, 360, 360, 360, 360]
            hangings = [360, 432, 504, 504, 504, 504]
            xml.send 'w:abstractNum', {'w:abstractNumId' => 0} do
              xml.send 'w:multiLevelType', {'w:val' => 'multilevel'}
              for i in 0..5
                xml.send 'w:lvl', {'w:ilvl' => i} do
                  xml.send 'w:start', {'w:val' => 1}
                  xml.send 'w:numFormat', {'w:val' => 'decimal'}
                  xml.send 'w:pStyle', {'w:val' => "Heading#{i+1}"}
                  xml.send 'w:lvlText', {'w:val' => texts[i]}
                  xml.send 'w:lvlJc', {'w:val' => 'left'}
                  xml.send 'w:pPr' do
                    xml.send 'w:ind', { 'w:left' => indents[i], 'w:hanging' => hangings[i] }
                  end
                end 
              end
            end
            
            pp document.toplevel_lists
            document.toplevel_lists.each_with_index do |model, i|
              xml.send 'w:abstractNum', { 'w:abstractNumId' => i + 1 } do
                xml.send 'w:multiLevelType', {'w:val' => 'hybridMultilevel'}
                model.level_map.each do |(level, type)|
                  if s = document.find_list_style(type, level)
                    pp s
                    xml.send 'w:lvl', { 'w:ilvl' => s.style_level } do
                      xml.send 'w:start',      { 'w:val' => s.style_start }
                      xml.send 'w:numFmt',     { 'w:val' => s.style_format }
                      xml.send 'w:lvlRestart', { 'w:val' => s.style_restart }
                      xml.send 'w:lvlText',    { 'w:val' => s.style_value }
                      xml.send 'w:lvlJc',      { 'w:val' => s.style_align }
                      xml.send 'w:pPr' do
                        xml.send 'w:ind', { 'w:left' => s.style_left, 'w:hanging' => s.style_indent }
                      end
                      xml.send 'w:rPr' do
                        xml.send 'w:u', { 'w:val' => 'none' }
                      end
                    end
                  end
                end
              end
            end
            
            # bind heading numbering
            xml.send 'w:num', {'w:numId' => 99} do
              xml.send 'w:abstractNumId', {'w:val' => 0}
            end
            
            # bind individual tables to abstract definitions
            document.toplevel_lists.each_with_index do |model, i|
              xml.send 'w:num', { 'w:numId' => i + 1 } do
                xml.send 'w:abstractNumId', { 'w:val' => i + 1 }
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
          'xmlns:mc'  => 'http://schemas.openxmlformats.org/markup-compatibility/2006',
          'xmlns:o'   => 'urn:schemas-microsoft-com:office:office',
          'xmlns:r'   => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
          'xmlns:m'   => 'http://schemas.openxmlformats.org/officeDocument/2006/math',
          'xmlns:v'   => 'urn:schemas-microsoft-com:vml',
          'xmlns:wp'  => 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing',
          'xmlns:w10' => 'urn:schemas-microsoft-com:office:word',
          'xmlns:w'   => 'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
          'xmlns:wne' => 'http://schemas.microsoft.com/office/word/2006/wordml',
          'xmlns:sl'  => 'http://schemas.openxmlformats.org/schemaLibrary/2006/main',
          'xmlns:a'   => 'http://schemas.openxmlformats.org/drawingml/2006/main',
          'xmlns:pic' => 'http://schemas.openxmlformats.org/drawingml/2006/picture',
          'xmlns:c'   => 'http://schemas.openxmlformats.org/drawingml/2006/chart',
          'xmlns:lc'  => 'http://schemas.openxmlformats.org/drawingml/2006/lockedCanvas',
          'xmlns:dgm' => 'http://schemas.openxmlformats.org/drawingml/2006/diagram'
        }
      end
   
    end
  end
end