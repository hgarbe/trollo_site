class Task < ApplicationRecord
  belongs_to :list

  # def self.single_list(list_id)
  #   List.find_by_sql(["
  #     Select *
  #     FROM lists AS l
  #     WHERE l.id = ?      
  #     ", list_id]).first
  # end



  def self.single_task(id)
    Task.find_by_sql(["
      Select *
      FROM tasks AS t
      WHERE t.id = ?      
      ", id]).first
  end

  # def self.delete_task(id)
  #   Task.find_by_sql(["
  #     DELETE FROM tasks AS t
  #     WHERE t.id = ?
  #     ;", id])
  # end

  def self.update_task(id, p)
    Task.find_by_sql(["
      UPDATE tasks AS t
      Set t_name = ?, list_id = ?, description = ?, t_priority = ?, updated_at = ?
      WHERE t.id = ?;
      ", p[:t_name], p[:list_id], p[:description], p[:t_priority], DateTime.now, id])
  end

  def self.create_task(p, id)
    Task.find_by_sql(["
      INSERT INTO tasks (t_name, description, t_priority, list_id, created_at, updated_at)
      VALUES (:name, :description, :priority, :list_id, :created_at, :updated_at);
      ",{
        name: p[:t_name],
        description: p[:description],
        priority: p[:t_priority],
        list_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now
      }])
  end

end
