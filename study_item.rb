require './category'
require 'sqlite3'

class StudyItem

  attr_reader :id, :title, :category, :description, :mark_as_done

  def initialize(id:, title:, category:, description:, done:)
    @id = id
    @title = title
    @category = category
    @description = description
    @done = done
  end

  def self.register
    print "\nDigite o título do item de estudo: "
    title = gets.chomp
    category = StudyBo.search_category.name
    print "\nDigite a descrição do item de estudo: "
    desc = gets.chomp
    StudyBo.register(title, category, desc)
  end

  def done?
    return false if @done.zero?

    true
  end

  def undone?
    return true if @done.zero?

    false
  end

  def self.select_all
    StudyBo.search_all_items.each do |item|
      puts "ID: #{item.id} | Título: #{item.title} | Categoria: #{item.category} | Descrição: #{item.description}#{' ***FINALIZADO***' if item.done?}"
    end
    puts 'Nenhum item cadastrado' if StudyBo.search_all_items.length.zero?
  end

  def self.mark_as_done
    StudyBo.search_all_items.each do |item|
      puts "ID: #{item.id} | Título: #{item.title} | Categoria: #{item.category} | Descrição: #{item.description}" if item.undone?
    end
    print 'Selecione um item pelo ID: '
    id = gets.to_i
    StudyBo.mark_as_done(id)
  end

  def self.select_by_category
    category = StudyBo.search_category.name
    puts "\nitens na categoria #{category}" if StudyBo.search_by_category(category).length.positive?

    StudyBo.search_by_category(category).each do |item|
      puts "ID: #{item.id} | Título: #{item.title} | Descrição: #{item.description}#{' ***FINALIZADO***' if item.done?}"
    end

    puts "\nNenhum item cadastrado na categoria #{category}" if StudyBo.search_by_category(category).length.zero?
    wait_and_clear
  end

  def self.select_by_value
    print "\nDigite uma palavra-chave: "
    value = gets.chomp
    clear
    puts "Itens com a palavra-chave \"#{value}\"" if StudyBo.search_by_value(value).length.positive?
    StudyBo.search_by_value(value).each do |item|
      puts "ID: #{item.id} | Título: #{item.title} | Categoria: #{item.category} | Descrição: #{item.description}#{' ***FINALIZADO***' if item.mark_as_done == 1}"
    end
    puts "Nenhum item encontrado com a palavra-chave \"#{value}\"" if StudyBo.search_by_value(value).empty?
    wait_and_clear
  end

  def self.delete_item
    puts 'Selecione um Item pelo ID'
    select_all
    print '--> '
    id = gets.to_i
    StudyBo.delete_item(id)
  end
end