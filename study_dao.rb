require 'sqlite3'

class StudyDao

  def insert_item(title, category, description)
    begin
      db = SQLite3::Database.open 'db_study.db'
      seq = db.execute "SELECT seq FROM sqlite_sequence"
      db.execute 'INSERT INTO items VALUES (?, ?, ?, ?, ? )',seq[0][0]+1, title, category, description, 0
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def select_all
    begin
      db = SQLite3::Database.open 'db_study.db'
      items = db.execute 'SELECT id, titulo, categoria, descricao, concluido FROM items'
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    items
  end

  def select_by_category(category)
    begin
      db = SQLite3::Database.open 'db_study.db'
      items = db.execute 'SELECT id, titulo, descricao, concluido FROM items WHERE categoria = ?', category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    items
  end

  def delete_item(id)
    begin
      db = SQLite3::Database.open 'db_study.db'
      items = db.execute 'DELETE FROM items WHERE id = ?', id
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

end