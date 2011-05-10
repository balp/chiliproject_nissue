class ChiliProject::Nissue::IssueView::Avatar < ChiliProject::Nissue::View
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def render(t)
    t.avatar(@issue.author, :size => '50')
  end
end

