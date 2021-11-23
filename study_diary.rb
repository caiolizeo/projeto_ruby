require './study_item'
require './category'
require 'io/console'

INSERT = 1
SELECT_ALL = 2
SELECT = 3
DELETE = 4
EXIT = 5

BY_CAREGORY = 1
BY_NAME = 2

def menu
  puts <<~MENU
    [#{INSERT}] Cadastrar um item para estudar
    [#{SELECT_ALL}] Ver todos os itens cadastrados
    [#{SELECT}] Buscar um item de estudo
    [#{DELETE}] Deletar um item de estudo
    [#{EXIT}] Sair
  MENU

  print 'Escolha uma opção: '
  gets.to_i
end

def insert
  cat = Category.new
  item = StudyItem.new
  print "\nDigite o título do item de estudo: "
  titulo = gets
  category = cat.select_category
  item.insert_item(titulo, category)
end

def select_all
  item = StudyItem.new
  count = 0
  items = item.select_all
  items.each do |i|
    count += 1
    puts "\nItem " + count.to_s + "\nTítulo: " + i[0] + "Categoria: " + i[1]
  end
end

def search_menu


  puts <<~MENU
    [#{BY_CAREGORY}] Buscar por categoria
    [#{BY_NAME}] Buscar no nome
    [#{EXIT}] Voltar
  MENU
  print 'Escolha uma opção: '
  opt = gets.to_i
  loop do
    case opt
    when BY_CAREGORY
      select_by_category
    when BY_NAME
      select_by_name
    when EXIT
      break
    end
    puts <<~MENU
    [#{BY_CAREGORY}] Buscar por categoria
    [#{BY_NAME}] Buscar no nome
    [#{EXIT}] Sair
    MENU
    print 'Escolha uma opção: '
    opt = gets.to_i
  end
end

def select_by_category
  cat = Category.new
  item = StudyItem.new
  categories = cat.select_category
  if item.select_by_category(categories).length > 0
    puts "\nitens na categoria " + categories
    puts item.select_by_category(categories)
  else
    puts "\nNenhum item cadastrado na categoria "+ categories
  end
end

def select_by_name

end

def delete_item
  item = StudyItem.new
  puts "\nSelecione um item: "
  items = item.select_all
  items.each.with_index(1) do |i, count|
    puts count.to_s + ". Título: " + i[0].chomp("\n") + "    Categoria: " + i[1]
  end
  print "--> "
  valor = gets
  while valor.to_i < 1 || valor.to_i > items.length
    print "--> "
    valor = gets
  end
  titulo = items[valor.to_i - 1][0]
  categoria = items[valor.to_i - 1][1]

  item.delete_item(titulo, categoria)

  puts "\nItem deletado com sucesso"
end

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

clear
opt = menu
loop do
  case opt
  when INSERT
    insert
  when SELECT_ALL
    select_all
  when SELECT
    search_menu
  when DELETE
    delete_item
  when EXIT
    break
  end
  wait_and_clear
  opt = menu
end