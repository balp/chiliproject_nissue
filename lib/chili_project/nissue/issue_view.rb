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

  def render_paragraphs(t)
    paragraphs.inject([]) { |m, o| m << o.render(t) << tag(:hr) }[0..-2]
  end

  def paragraphs
    [
      fields_paragraph,
      description_paragraph,
      sub_issues_paragraph,
      related_issues_paragraph
    ].select(&:present?).select(&:visible?)
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

  def fields_paragraph
    @fields_paragraph ||= ChiliProject::Nissue::IssueView::FieldsParagraph.new(@issue)
  end

  def description_paragraph
    @description_paragraph ||= ChiliProject::Nissue::IssueView::DescriptionParagraph.new(@issue)
  end

  def sub_issues_paragraph
    @sub_issues_paragraph ||= ChiliProject::Nissue::IssueView::SubIssuesParagraph.new(@issue)
  end

  def related_issues_paragraph
    @related_issues_paragraph ||= ChiliProject::Nissue::IssueView::RelatedIssuesParagraph.new(@issue)
  end
end
