# To change this template, choose Tools | Templates
# and open the template in the editor.

class XmlController < ApplicationController
  
  def import
    XMLReader::delete_all
    XMLReader::read_xml('essai2.xml')
  end

  def export
     @doc = XMLWriter::write_xml
     XMLWriter::save_to_file('essai2.xml', @doc)
  end

end
