class ChiliProject::Nissue::IssueView::FieldsParagraph < ChiliProject::Nissue::Paragraph
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def render(t)
    t.content_tag(:table, :class => 'attributes') do
      str = StringIO.new
      fields.each_slice(2) do |elems|
        str << t.content_tag(:tr) do
          elems.map do |id, paragraph|
            content_tag(:th, paragraph.label + ':', :class => id) +
            content_tag(:td, paragraph.render(t), :class => id)
          end.join
        end
      end
      str.string
    end
  end

  def fields
    fields = ActiveSupport::OrderedHash.new

    fields[:status] = ChiliProject::Nissue::SimpleParagraph.new(:status) { |t| @issue.status.name }
    fields[:start_date] = ChiliProject::Nissue::SimpleParagraph.new(:start_date) { |t| t.format_date(@issue.start_date) }

    fields[:priority] = ChiliProject::Nissue::SimpleParagraph.new(:priority) { |t| @issue.priority.name }
    fields[:due_date] = ChiliProject::Nissue::SimpleParagraph.new(:due_date) { |t| t.format_date(@issue.due_date) }

    fields[:assigned_to] = ChiliProject::Nissue::SimpleParagraph.new(:assigned_to) { |t| [t.avatar(@issue.assigned_to, :size => "14"), (@issue.assigned_to ? t.link_to_user(@issue.assigned_to) : "-")].compact.join }
    fields[:done_ratio] = ChiliProject::Nissue::SimpleParagraph.new(:done_ratio) { |t| t.progress_bar(@issue.done_ratio, :width => '80px', :legend => "#{@issue.done_ratio}%") }

    fields[:category] = ChiliProject::Nissue::SimpleParagraph.new(:category) { |t| @issue.category ? h(@issue.category.name) : "-" }
    fields[:spent_time] = ChiliProject::Nissue::IssueView::SpentTimeParagraph.new(@issue)

    fields[:fixed_version] = ChiliProject::Nissue::SimpleParagraph.new(:fixed_version) { |t| @issue.fixed_version ? t.link_to_version(@issue.fixed_version) : "-" }
    fields[:estimated_hours] = ChiliProject::Nissue::IssueView::EstimatedTimeParagraph.new(@issue)

    fields.reject! { |k,p| !p.visible? }

    fields
  end
end
