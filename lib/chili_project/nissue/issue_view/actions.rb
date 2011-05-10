class ChiliProject::Nissue::IssueView::Actions < ChiliProject::Nissue::View
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def render(template)
    template.render :partial => 'action_menu'
  end
end
