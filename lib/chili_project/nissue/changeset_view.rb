class ChiliProject::Nissue::ChangesetView < ChiliProject::Nissue::View
  def initialize(changesets, issue)
    @changesets = changesets
    @issue = issue
  end

  def render(t)
    return if @changesets.blank?

    content_tag(:div, [
      content_tag(:h3, l(:label_associated_revisions)),
      t.render( :partial => 'issues/changesets', :locals => { :changesets => @changesets })
    ].join, :id => 'issue-changesets')
  end
end
