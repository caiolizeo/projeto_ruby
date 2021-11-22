require './category'
require 'sqlite3'

class StudyItem

  def select_category
    category = Category.new
    categories = category.list_categories
    count = 1
    puts "\nSelecione uma categoria: "
    categories.each do |c|
      puts "#{count.to_s}. #{c}"
      count += 1
    end
    print '-->'
    cat_number = gets

    while cat_number.to_i < 1 || cat_number.to_i > categories.length
      print '-->'
      cat_number = gets
    end

    categories[cat_number.to_i - 1]
  end

  def insert_item
    print "\nDigite o título do item de estudo: "
    titulo = gets
    categoria = select_category
    begin
      db = SQLite3::Database.open 'db_study.db'
      db.execute 'INSERT INTO items VALUES ( ?, ? )', titulo, categoria

      puts "Item cadastrado com sucesso!\n"
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end

  def select_all
    begin
      db = SQLite3::Database.open 'db_study.db'
      items = db.execute 'SELECT titulo, categoria FROM items'

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
      items = db.execute 'SELECT titulo FROM items WHERE categoria = ?', category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
    items
  end

  def delete_item(titulo, category)
    begin
      db = SQLite3::Database.open 'db_study.db'
      items = db.execute 'DELETE FROM items WHERE titulo = ? AND categoria = ?', titulo, category
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close
    end
  end
end