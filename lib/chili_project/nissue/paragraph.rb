class ChiliProject::Nissue::Paragraph < ChiliProject::Nissue::View
  attr_writer :label

  def label(t = nil)
    @label
  end

  def visible?
    true
  end
end
