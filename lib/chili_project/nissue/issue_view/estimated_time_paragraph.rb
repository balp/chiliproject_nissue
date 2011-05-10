class ChiliProject::Nissue::IssueView::EstimatedTimeParagraph < ChiliProject::Nissue::Paragraph
  def initialize(issue)
    @issue = issue
  end

  def label
    l(:field_estimated_hours)
  end

  def visible?
    @issue.estimated_hours
  end

  def render(t)
    t.l_hours(@issue.estimated_hours)
  end
end
