require 'sqlite3'

class Category

  def list_categories
    db = SQLite3::Database.open 'db_study.db'
    db.results_as_hash = true
    categorias = db.execute "SELECT * FROM categoria"
    db.close

    cat = categorias.map { |i| i['categoria'] }
  end

  def select_category
    category = Category.new
    categories = category.list_categories

    puts "\nSelecione uma categoria: "
    categories.each.with_index(1) do |c, i|
      puts "#{i.to_s}. #{c}"

    end
    print '-->'
    cat_number = gets

    while cat_number.to_i < 1 || cat_number.to_i > categories.length
      print '-->'
      cat_number = gets
    end

    categories[cat_number.to_i - 1]
  end
end