class ChiliProject::Nissue::IssueView::Heading < ChiliProject::Nissue::View
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def render(t)
    content_tag(:div, t.render_issue_subject_with_tree(@issue), :class => 'subject')
  end
end
