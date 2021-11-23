require './study_dao'
require './study_item'
require './category'

class StudyBo

  def register(title, category, description)
    dao = StudyDao.new
    dao.insert_item(title, category, description)
  end

  def register_category(category)
    dao = StudyDao.new
    dao.insert_category(category)
  end

  def mark_as_done(id)
    dao = StudyDao.new
    dao.update_done(id)
  end

  def search_all_items
    study_objects = []
    dao = StudyDao.new
    dao.select_all.each do |item|
      study_objects << StudyItem.new(item['id'], item['titulo'], item['categoria'], item['descricao'], item['concluido'])
    end
    study_objects
  end

  def search_by_category(category)
    study_objects = []
    dao = StudyDao.new
    dao.select_by_category(category).each do |item|
      study_objects << StudyItem.new(item['id'], item['titulo'], category, item['descricao'], item['concluido'])
    end
    study_objects
  end

  def search_by_value(value)
    study_objects = []
    dao = StudyDao.new
    dao.select_by_value(value).each do |item|
      study_objects << StudyItem.new(item['id'],item['titulo'],item['categoria'],item['descricao'],item['concluido'])
    end
    study_objects
  end

  def delete_item(id)
    dao = StudyDao.new
    dao.delete_item(id)
  end

  def delete_category(cat)
    dao = StudyDao.new
    dao.delete_category(cat)
  end

  def search_categories
    category_objects = []
    dao = StudyDao.new
    dao.select_categories.each do |category|
      category_objects << Category.new(category['categoria'])
    end
    category_objects
  end

  def search_category
    categories = search_categories
    puts "\nSelecione uma categoria: "

    categories.each.with_index(1) do |c, i|
      puts "#{i.to_s}. #{c.name}"
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
