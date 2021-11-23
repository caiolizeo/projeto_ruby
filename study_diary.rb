require './study_bo'
require './category'
require 'io/console'

INSERT = 1
SELECT_ALL = 2
SELECT = 3
DELETE = 4
EXIT = 5

BY_CAREGORY = 1
BY_VALUE = 2

def clear
  system 'clear'
end

def wait_keypress
  puts
  puts "\nPressione qualquer tecla para continuar"
  STDIN.getch
end

def wait_and_clear
  wait_keypress
  clear
end

def menu
  puts <<~MENU
    [#{INSERT}] Cadastrar um item para estudar
    [#{SELECT_ALL}] Ver todos os itens cadastrados
    [#{SELECT}] Buscar um item de estudo
    [#{DELETE}] Deletar um item de estudo
    [#{EXIT}] Sair
  MENU

  print "\nEscolha uma opção: "
  gets.to_i
end

def register

  bo = StudyBo.new
  print "\nDigite o título do item de estudo: "
  titulo = gets.chomp
  category = bo.search_category.name
  print "\nDigite a descrição do item de estudo: "
  desc = gets.chomp
  bo.register(titulo, category, desc)
end

def select_all
  bo = StudyBo.new
  bo.search_all_items.each do |i|
    puts "ID: #{i.id} | Título: #{i.title} | Categoria: #{i.category} | Descrição: #{i.description}#{' ***FINALIZADO***' if i.done == 1}"
  end
  puts "Nenhum item cadastrado" if bo.search_all_items.length == 0
end

def s_menu
  puts <<~MENU
    [#{BY_CAREGORY}] Buscar por categoria
    [#{BY_VALUE}] Buscar por palavra-chave
    [#{EXIT}] Voltar
  MENU
  print 'Escolha uma opção: '
  opt = gets.to_i
end

def search_menu
  opt = s_menu
  loop do
    case opt
    when BY_CAREGORY
      select_by_category
    when BY_VALUE
      select_by_value
    when EXIT
      break
    end
    opt = s_menu
  end
end

def select_by_category
  bo = StudyBo.new
  category = bo.search_category.name
  puts "\nitens na categoria " + category if bo.search_by_category(category).length > 0

  bo.search_by_category(category).each do |item|
    puts "ID: #{item.id} | Título: #{item.title} | Descrição: #{item.description}#{' ***FINALIZADO***' if item.done == 1}"
  end

  puts "\nNenhum item cadastrado na categoria " + category if bo.search_by_category(category).length < 1
  wait_and_clear
end

def select_by_value
  bo = StudyBo.new
  print "\nDigite uma palavra-chave: "
  value = gets.chomp
  clear
  puts "Itens com a palavra-chave \"#{value}\"" if bo.search_by_value(value).length > 0
  bo.search_by_value(value).each do |i|
    puts "ID: #{i.id} | Título: #{i.title} | Categoria: #{i.category} | Descrição: #{i.description}#{' ***FINALIZADO***' if i.done == 1}"
  end
  puts "Nenhum item encontrado com a palavra-chave \"#{value}\"" if bo.search_by_value(value).length < 1
  wait_and_clear
end

def delete_item
  bo = StudyBo.new
  puts "Selecione um Item pelo ID"
  select_all
  print "--> "
  id = gets.to_i
  bo.delete_item(id)
end

clear
opt = menu
loop do
  clear
  case opt
  when INSERT
    register
  when SELECT_ALL
    select_all
  when SELECT
    search_menu
  when DELETE
    delete_item
  when EXIT
    break
  else
    puts "Opção inválida"
  end

  wait_and_clear
  opt = menu
end