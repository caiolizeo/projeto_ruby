require './study_bo'
require './category'
require './study_item'
require 'io/console'

INSERT = 1
SELECT_ALL = 2
MARK_AS_DONE = 3
SELECT = 4
DELETE = 5
INSERT_CAT = 6
DELETE_CAT = 7
EXIT = 8

BY_CATEGORY = 1
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
    [#{MARK_AS_DONE}] Marcar estudo como finalizado
    [#{SELECT}] Buscar um item de estudo
    [#{DELETE}] Deletar um item de estudo
    [#{INSERT_CAT}] Cadastrar categoria
    [#{DELETE_CAT}] Deletar categoria
    [#{EXIT}] Sair
  MENU
  print "\nEscolha uma opção: "
  gets.to_i
end

def s_menu
  puts <<~MENU
    [#{BY_CATEGORY}] Buscar por categoria
    [#{BY_VALUE}] Buscar por palavra-chave
    [#{EXIT}] Voltar
  MENU
  print 'Escolha uma opção: '
  gets.to_i
end

def search_menu
  opt = s_menu
  loop do
    case opt
    when BY_CATEGORY
      StudyItem.select_by_category
    when BY_VALUE
      StudyItem.select_by_value
    when EXIT
      break
    end
    opt = s_menu
  end
end

clear
opt = menu
loop do
  clear
  case opt
  when INSERT
    StudyItem.register
  when SELECT_ALL
    StudyItem.select_all
  when MARK_AS_DONE
    StudyItem.mark_as_done
  when SELECT
    search_menu
  when DELETE
    StudyItem.delete_item
  when INSERT_CAT
    Category.register_category
  when DELETE_CAT
    Category.delete_category
  when EXIT
    break
  else
    puts 'Opção inválida'
  end

  wait_and_clear
  opt = menu
end
