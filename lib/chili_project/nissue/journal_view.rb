class ChiliProject::Nissue::JournalView < ChiliProject::Nissue::View
  def initialize(journals, issue)
    @journals = journals
    @issue = issue
  end

  def render(t)
    return if @journals.blank?

    content_tag(:div, [
      content_tag(:h3, l(:label_history)),
      t.render(:partial => 'issues/history', :locals => {:issue => @issue, :journals => @journals})
    ], :id => 'history')
  end
end
