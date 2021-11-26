require 'sqlite3'

class StudyDao

  def self.insert_item(title, category, description)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.results_as_hash = true
      seq = db.execute 'SELECT seq FROM sqlite_sequence'
      db.execute 'INSERT INTO items VALUES (?, ?, ?, ?, ? )', seq[0]['seq'] + 1, title, category, description, 0
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def self.insert_category(category)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.execute 'INSERT INTO category VALUES ( ? )', category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def self.select_all
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.results_as_hash = true
      items = db.execute 'SELECT * FROM items'
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    items
  end

  def self.select_by_category(category)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.results_as_hash = true
      items = db.execute 'SELECT id, title, category, description, done FROM items WHERE category = ?', category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    items
  end

  def self.select_by_value(value)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.results_as_hash = true
      items = db.execute 'SELECT id, title, category, description, done FROM items WHERE title LIKE ? OR description LIKE ?', '%' + value + '%', '%' + value + '%'
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    items
  end

  def self.delete_item(id)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.execute 'DELETE FROM items WHERE id = ?', id
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def self.delete_category(category)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.execute 'DELETE FROM category WHERE category = ?', category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def self.update_done(id)
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.execute 'UPDATE items SET done = 1 WHERE id = ?', id
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def self.select_categories
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.results_as_hash = true
      categories = db.execute 'SELECT * FROM category'
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    categories
  end
end