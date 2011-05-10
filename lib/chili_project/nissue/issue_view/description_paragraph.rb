class ChiliProject::Nissue::IssueView::DescriptionParagraph < ChiliProject::Nissue::Paragraph
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def label
    l(:field_description)
  end

  def visible?
    @issue.description? or @issue.attachments.any?
  end

  def render(t)
    return unless visible?

    str = StringIO.new

    if @issue.description?
      str << content_tag(:div,
                         t.link_to_remote_if_authorized(l(:button_quote),
                                                        {:url => {:controller => 'journals', :action => 'new', :id => @issue}},
                                                        :class => 'icon icon-comment'),
                         :class => 'contextual')

      str << content_tag(:p, content_tag(:strong, label))
      str << content_tag(:div, t.textilizable(@issue, :description, :attachments => @issue.attachments), :class => 'wiki')
    end

    str << t.link_to_attachments(@issue)

    str << t.call_hook(:view_issues_show_description_bottom, :issue => @issue)

    str.string
  end
end
