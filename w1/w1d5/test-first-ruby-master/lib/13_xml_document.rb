class XmlDocument
  attr_accessor :counter
  attr_reader :indent
  def initialize(indent = false)
    @indent = indent
    @counter = 0
  end

  def method_missing(method_name, options = {},&block)
    method_name = method_name.to_s
    return_value = ""
    @counter += 1
    indent ? spaces = "  " * (counter - 1) : spaces = ""
    indent ? nl = "\n" : nl = ""

    unless options.empty?
      options.each do |key, value|
        return_value << "#{spaces}<#{method_name} #{key.to_s}='#{value}'/>#{nl}"
      end
    else
      return_value << "#{spaces}<#{method_name}/>#{nl}"
    end

    if block_given?
      return_value = "#{spaces}<#{method_name}>#{nl}#{block.call}#{spaces}</#{method_name}>#{nl}"
    end

    @counter -= 1
    return_value
  end
end
