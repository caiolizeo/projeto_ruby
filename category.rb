require 'sqlite3'

class Category

  def list_categories
    db = SQLite3::Database.open 'db_study.db'
    db.results_as_hash = true
    categorias = db.execute "SELECT * FROM categoria"
    db.close

    cat = categorias.map { |i| i['categoria'] }
  end

end