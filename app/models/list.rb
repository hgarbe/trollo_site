class List < ApplicationRecord
  belongs_to :board
  has_many :tasks, dependent: :destroy

  def self.single_board(board_id)
    Board.find_by_sql(["
      Select *
      FROM boards AS b
      WHERE b.id = ?      
      ", board_id]).first
  end

  def self.all_local_lists(id)
    List.find_by_sql(["
      Select *
      FROM lists AS l
      WHERE l.board_id = ?      
      ", id])
  end

  def self.single_list(id)
    List.find_by_sql(["
      Select *
      FROM lists AS l
      WHERE l.id = ?      
      ", id]).first
  end

  # def self.delete_list(id)
  #   List.find_by_sql(["
  #     DELETE FROM lists AS l
  #     JOIN tasks
  #     WHERE l.id = ?
  #     ;", id])
  # end

  def self.update_list(id, p)
    List.find_by_sql(["
      UPDATE lists AS l
      Set l_name = ?, l_priority = ?, updated_at = ?
      WHERE l.id = ?;
      ", p[:l_name], p[:l_priority], DateTime.now, id])
  end

  def self.create_list(p, id)
    List.find_by_sql(["
      INSERT INTO lists (l_name, l_priority, board_id, created_at, updated_at)
      VALUES (:name, :priority, :board_id, :created_at, :updated_at);
      ",{
        name: p[:l_name],
        priority: p[:l_priority],
        board_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now
      }])
  end

  
end
