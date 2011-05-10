class ChiliProject::Nissue::IssueView < ChiliProject::Nissue::View
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def render(t)
    content_tag(:div, [
      title.render(t),
      content_tag(:div, [
        avatar.render(t),
        heading.render(t),
        *render_paragraphs(t)
      ], :class => @issue.css_classes  + ' details')
    ], :class => 'issue-view')
  end

  def title
    @title ||= ChiliProject::Nissue::IssueView::Title.new(@issue)
  end

  def avatar
    @avatar ||= ChiliProject::Nissue::IssueView::Avatar.new(@issue)
  end

  def heading
    @heading ||= ChiliProject::Nissue::IssueView::Heading.new(@issue)
  end

  def render_paragraphs(t)
    paragraphs.inject([]) { |m, o| m << o.render(t) << tag(:hr) }[0..-2]
  end

  def paragraphs
    @paragraphs ||= [
      ChiliProject::Nissue::IssueView::FieldsParagraph.new(@issue),
      ChiliProject::Nissue::IssueView::DescriptionParagraph.new(@issue),
      ChiliProject::Nissue::IssueView::SubIssuesParagraph.new(@issue),
      ChiliProject::Nissue::IssueView::RelatedIssuesParagraph.new(@issue)
    ].select { |paragraph| paragraph.visible? }
  end

  def journals
  end
end
