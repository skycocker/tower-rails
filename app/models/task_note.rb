# frozen_string_literal: true

class TaskNote < ApplicationRecord
  belongs_to :task
end
