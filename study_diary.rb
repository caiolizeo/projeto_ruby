require './study_item'
require './category'

class StudyDiary
  item = StudyItem.new

  opc = ''
  while opc.to_i != 5

    puts "\n[1] Cadastrar um item para estudar"
    puts '[2] Ver todos os itens cadastrados'
    puts '[3] Buscar um item de estudo'
    puts '[4] Excluir um item de estudo'
    puts '[5] Sair'
    print "Escolha uma opção: "
    opc = gets

    case opc.to_i
    when 1
      item.insert_item

    when 2
      count = 0
      items = item.select_all
      items.each do |i|
        count += 1
        puts "\nItem " + count.to_s + "\nTítulo: " + i[0] + "Categoria: " + i[1]
      end

    when 3
      categoria = item.select_category
      if item.select_by_category(categoria).length > 0
        puts "\nitens na categoria: " + categoria
        puts item.select_by_category(categoria)
      else
        puts "\nNenhum item cadastrado!"
      end

    when 4
      count = 0
      puts 'Selecione um item: '
      items = item.select_all
      items.each do |i|
        count += 1
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
    end
  end

end