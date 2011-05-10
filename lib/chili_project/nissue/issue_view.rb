class ChiliProject::Nissue::IssueView < ChiliProject::Nissue::View
  attr_reader :issue

  def initialize(issue, &block)
    @issue = issue

    if block.present?
      if block.arity == 1
        block.call(self)
      else
        instance_eval(block)
      end
    end
  end

  def render(t)
    content_tag(:div, [
      actions.render(t),
      title.render(t),
      content_tag(:div, [
        avatar.render(t),
        heading.render(t),
        paragraphs.inject([]) { |m, o| m << o.render(t) << tag(:hr) }[0..-2]
      ].flatten, :class => @issue.css_classes  + ' details'),
      ''
    ], :class => 'issue-view')
  end

  def actions
    @actions ||= ChiliProject::Nissue::IssueView::Actions.new(@issue)
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
