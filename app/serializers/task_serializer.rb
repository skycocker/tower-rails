class TaskSerializer < Panko::Serializer
  attributes :id, :task_list_id, :content,
             :list_position, :notes_present,
             :happens_at, :completed_at,
             :latitude, :longitude,
             :created_at, :updated_at

  def notes_present
    return false if object.task_notes.blank?

    object.task_notes.any? { |note| Nokogiri::HTML.parse(note.content).text.present? }
  end
end
