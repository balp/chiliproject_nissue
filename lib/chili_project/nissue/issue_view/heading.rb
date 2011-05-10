class ChiliProject::Nissue::IssueView::Heading < ChiliProject::Nissue::View
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def render(t)
    content_tag(:div, t.render_issue_subject_with_tree(@issue), :class => 'subject') +
    content_tag(:p, [
      t.authoring(@issue.created_on, @issue.author),
      '. ',
      @issue.created_on != @issue.updated_on ? l(:label_updated_time, t.time_tag(@issue.updated_on)) + '.' : ''
    ], :class => 'author')

  end
end
