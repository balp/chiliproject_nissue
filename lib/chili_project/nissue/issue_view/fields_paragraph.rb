class ChiliProject::Nissue::IssueView::FieldsParagraph < ChiliProject::Nissue::Paragraph
  attr_reader :issue

  def initialize(issue)
    @issue = issue
  end

  def render(t)
    content_tag(:table, [
      render_fields(default_fields, t),
      render_fields(custom_fields, t),
      call_hook(t)
    ], :class => 'attributes')
  end

  def call_hook(t)
    t.call_hook(:view_issues_show_details_bottom, hook_context(t))
  end

  def hook_context(t)
    {:issue => @issue}
  end

  def render_fields(fields, t)
    str = StringIO.new

    half = (fields.size / 2.0).ceil
    values = fields.values
    keys   = fields.keys

    half.times do |i|
      str << t.content_tag(:tr) do
        [i, i + half].map do |index|
          paragraph = values[index]

          next unless paragraph.present? && paragraph.visible?

          label = paragraph.label
          content_tag(:th, label.present? ? label + ':' : '', :class => keys[index]) +
          content_tag(:td, paragraph.render(t), :class => keys[index])
        end
      end
    end

    str.string
  end

  def default_fields
    fields = ActiveSupport::OrderedHash.new

    fields[:status] = ChiliProject::Nissue::SimpleParagraph.new(:status) { |t| @issue.status.name }
    fields[:priority] = ChiliProject::Nissue::SimpleParagraph.new(:priority) { |t| @issue.priority.name }
    fields[:assigned_to] = ChiliProject::Nissue::SimpleParagraph.new(:assigned_to) { |t| [t.avatar(@issue.assigned_to, :size => "14"), (@issue.assigned_to ? t.link_to_user(@issue.assigned_to) : "-")].compact.join }
    fields[:category] = ChiliProject::Nissue::SimpleParagraph.new(:category) { |t| @issue.category ? h(@issue.category.name) : "-" }
    fields[:fixed_version] = ChiliProject::Nissue::SimpleParagraph.new(:fixed_version) { |t| @issue.fixed_version ? t.link_to_version(@issue.fixed_version) : "-" }

    fields[:start_date] = ChiliProject::Nissue::SimpleParagraph.new(:start_date) { |t| t.format_date(@issue.start_date) }
    fields[:due_date] = ChiliProject::Nissue::SimpleParagraph.new(:due_date) { |t| t.format_date(@issue.due_date) }
    fields[:done_ratio] = ChiliProject::Nissue::SimpleParagraph.new(:done_ratio) { |t| t.progress_bar(@issue.done_ratio, :width => '80px', :legend => "#{@issue.done_ratio}%") }
    fields[:spent_time] = ChiliProject::Nissue::IssueView::SpentTimeParagraph.new(@issue)
    fields[:estimated_hours] = ChiliProject::Nissue::IssueView::EstimatedTimeParagraph.new(@issue)

    fields
  end

  def custom_fields
    fields = ActiveSupport::OrderedHash.new

    return fields if @issue.custom_field_values.empty?

    @issue.custom_field_values.each do |custom_value|
      fields[custom_value.custom_field.name] = ChiliProject::Nissue::IssueView::CustomFieldParagraph.new(custom_value)
    end

    fields
  end
end
