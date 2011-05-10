class ChiliProject::Nissue::IssueView::Title < ChiliProject::Nissue::View
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def render(t)
    content_tag(:h2, %Q{
      #{@issue.tracker.name}
      ##{@issue.id}
      #{t.call_hook(:view_issues_show_identifier, :issue => @issue)}
    })
  end
end

