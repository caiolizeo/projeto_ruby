require 'sqlite3'

class Db
  begin

    db = SQLite3::Database.new 'db_study.db'

    db.execute <<~SQL
      CREATE TABLE categoria(
       categoria varchar(255)
      );
    SQL

    category = ['Ruby', 'Rails', 'HTML', 'Javascript']

    category.each do |data|
      db.execute "INSERT INTO categoria VALUES ( ? )", data
    end

  rescue SQLite3::Exception => e
    puts e
  ensure
    db.close if db
  end

  begin
    db = SQLite3::Database.new 'db_study.db'

    db.execute <<~SQL
      CREATE TABLE items(
        titulo varchar(255),
        categoria varchar(255)
      );
    SQL
  rescue SQLite3::Exception => e
    puts e
  ensure
    db.close if db
  end
end