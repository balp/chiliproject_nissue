class ChiliProject::Nissue::EmptyParagraph < ChiliProject::Nissue::Paragraph
  def initialize
  end

  def label(t = nil)
    ''
  end

  def render(t)
    ''
  end

  def visible?
    true
  end
end
