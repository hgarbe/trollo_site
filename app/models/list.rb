class List < ApplicationRecord
  belongs_to :board
  has_many :tasks, dependent: :destroy

  def self.single_board(board_id)
    Board.find_by_sql(["
      Select *
      FROM boards AS board
      WHERE board.id = ?      
      ", board_id]).first
  end

  def self.all_local_lists(id)
    List.find_by_sql(["
      Select *
      FROM lists 
      WHERE board_id = ?      
      ", id])
  end

  def self.single_list(id)
    List.find_by_sql(["
      Select *
      FROM lists AS lists
      WHERE lists.id = ?      
      ", id]).first
  end

  def self.delete_list(id)
    List.find_by_sql(["
      DELETE FROM lists AS lists
      JOIN tasks
      WHERE list.id = ?
      ;", id])
  end

  def self.update_list(id, p)
    List.find_by_sql(["
      UPDATE lists AS lists
      Set title = ?, priority = ?, updated_at = ?
      WHERE list.id = ?;
      ", p[:title], p[:priority], DateTime.now, id])
  end

  def self.create_list(p, id)
    List.find_by_sql(["
      INSERT INTO lists (title, priority, board_id, created_at, updated_at)
      VALUES (:title, :priority, :board_id, :created_at, :updated_at);
      ",{
        title: p[:title],
        priority: p[:priority],
        board_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now
      }])
  end

  
end
