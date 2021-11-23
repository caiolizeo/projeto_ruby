require './category'
require 'sqlite3'

class StudyItem
  attr_accessor :id, :title, :category, :description, :done
  def initialize(id, title, category, description, done)
    @id = id
    @title = title
    @category = category
    @description = description
    @done = done
  end
end