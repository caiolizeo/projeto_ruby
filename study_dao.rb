require 'sqlite3'

class StudyDao

  def insert_item(title, category, description)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.results_as_hash = true
      seq = db.execute "SELECT seq FROM sqlite_sequence"
      db.execute 'INSERT INTO items VALUES (?, ?, ?, ?, ? )',seq[0]["seq"]+1, title, category, description, 0
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def insert_category(category)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.execute "INSERT INTO categoria VALUES ( ? )", category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def select_all
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.results_as_hash = true
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
      db.results_as_hash = true
      items = db.execute 'SELECT id, titulo, descricao, concluido FROM items WHERE categoria = ?', category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    items
  end

  def select_by_value(value)
    begin
    db = SQLite3::Database.open 'db_study.db'
    db.results_as_hash = true
    items = db.execute 'SELECT id, titulo, categoria, descricao, concluido FROM items WHERE titulo LIKE ? OR descricao LIKE ?', "%"+value+"%", "%"+value+"%"
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
      db.execute 'DELETE FROM items WHERE id = ?', id
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def delete_category(category)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.execute "DELETE FROM categoria WHERE categoria = ?", category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def update_done(id)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.execute 'UPDATE items SET concluido = 1 WHERE id = ?', id
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def select_categories
    begin
    db = SQLite3::Database.open 'db_study.db'
    db.results_as_hash = true
    categorias = db.execute "SELECT * FROM categoria"
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    categorias
  end
end