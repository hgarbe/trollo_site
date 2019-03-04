class Task < ApplicationRecord
  belongs_to :list

  def self.single_list(list_id)
    List.find_by_sql(["
      Select *
      FROM lists AS lists
      WHERE list.id = ?      
      ", list_id]).first
  end



  def self.single_task(id)
    Task.find_by_sql(["
      Select *
      FROM tasks AS tasks
      WHERE tasks.id = ?      
      ", id]).first
  end

  def self.delete_task(id)
    Task.find_by_sql(["
      DELETE FROM tasks AS tasks
      WHERE tasks.id = ?
      ;", id])
  end

  def self.update_task(id, p)
    Task.find_by_sql(["
      UPDATE tasks AS t
      Set title = ?, list_id = ?, description = ?, priority = ?, updated_at = ?
      WHERE t.id = ?;
      ", p[:title], p[:list_id], p[:description], p[:priority], DateTime.now, id])
  end

  # def self.create_task(p, id)
  #   Task.find_by_sql(["
  #     INSERT INTO tasks (title, description, priority, list_id, created_at, updated_at)
  #     VALUES (:title, :description, :priority, :list_id, :created_at, :updated_at);
  #     ",{
  #       name: p[:title],
  #       description: p[:description],
  #       priority: p[:priority],
  #       list_id: id,
  #       created_at: DateTime.now,
  #       updated_at: DateTime.now
  #     }])
  # end

end