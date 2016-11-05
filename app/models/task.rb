class Task < ApplicationRecord
  belongs_to :user

  enum status: {
    incomplete: 0,
    wip: 1,
    completed: 2
  }

  def username
    user.name
  end
end
