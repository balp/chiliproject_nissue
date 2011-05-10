class ChiliProject::Nissue::SimpleParagraph < ChiliProject::Nissue::Paragraph
  def initialize(identifier, &block)
    @identifier = identifier
    @block = block
  end

  def label(t = nil)
    l("field_#{@identifier}")
  end

  def visible?
    !!@block
  end

  def render(t)
    @block.call(t)
  end
end
