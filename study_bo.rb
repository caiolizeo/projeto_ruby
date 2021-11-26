require './study_dao'
require './study_item'
require './category'

class StudyBo

  def self.register(title, category, description)
    StudyDao.insert_item(title, category, description)
  end

  def self.register_category(category)
    StudyDao.insert_category(category)
  end

  def self.mark_as_done(id)
    StudyDao.update_done(id)
  end

  def self.search_all_items
    study_objects = []
    StudyDao.select_all
            .map { |hash| hash.transform_keys!(&:to_sym) }
            .map { |item| study_objects << StudyItem.new(**item) }
    study_objects
  end

  def self.search_by_category(category)
    study_objects = []
    StudyDao.select_by_category(category)
       .map { |hash| hash.transform_keys!(&:to_sym) }
       .map { |item| study_objects << StudyItem.new(**item) }
    study_objects
  end

  def self.search_by_value(value)
    study_objects = []

    StudyDao.select_by_value(value)
            .map { |hash| hash.transform_keys!(&:to_sym) }
            .map { |item| study_objects << StudyItem.new(**item) }
    study_objects
  end

  def self.delete_item(id)
    StudyDao.delete_item(id)
  end

  def self.delete_category(cat)
    StudyDao.delete_category(cat)
  end

  def self.search_categories
    category_objects = []
    StudyDao.select_categories.each do |category|
      category_objects << Category.new(category['category'])
    end
    category_objects
  end

  def self.search_category
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
