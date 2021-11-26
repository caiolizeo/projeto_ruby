require 'sqlite3'

class Category

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.register_category
    print "\nDigite o nome da categoria: "
    cat = gets.chomp
    StudyBo.register_category(cat)
  end

  def self.delete_category
    category = StudyBo.search_category.name
    StudyBo.delete_category(category)
  end

end