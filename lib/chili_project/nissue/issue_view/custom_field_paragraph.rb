class ChiliProject::Nissue::IssueView::CustomFieldParagraph < ChiliProject::Nissue::Paragraph
  def initialize(custom_value)
    @custom_value = custom_value
  end

  def label
    h(@custom_value.custom_field.name)
  end

  def render(t)
    t.simple_format_without_paragraph(h(t.show_value(@custom_value)))
  end
end
