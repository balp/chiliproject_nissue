class ChiliProject::Nissue::IssueView::SubIssuesParagraph < ChiliProject::Nissue::Paragraph
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def visible?
    !@issue.leaf? or User.current.allowed_to?(:manage_subtasks, @issue.project)
  end

  def label
    l(:label_subtask_plural)
  end

  def render(t)
    return unless visible?

    str = StringIO.new

    if User.current.allowed_to?(:manage_subtasks, @issue.project)
      str << content_tag(:div,
                  t.link_to(l(:button_add), {:controller => 'issues', :action => 'new', :project_id => @issue.project, :issue => {:parent_issue_id => @issue}}),
                  :class => 'contextual')
    end

    str << content_tag(:p, content_tag(:strong, label))

    str << t.render_descendants_tree(@issue) unless @issue.leaf?

    str.string

    content_tag(:div, str.string, :id => 'issue_tree')
  end
end
