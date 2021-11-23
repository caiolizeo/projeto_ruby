require './study_dao'
require './study_item'

class StudyBo

  def register(title, category, description)
    dao = StudyDao.new
    dao.insert_item(title, category, description)
  end

  def search_all_items
    study_objects = []
    dao = StudyDao.new
    dao.select_all.each do |item|
      study_objects << StudyItem.new(item[0], item[1], item[2], item[3], item[4])
    end
    study_objects
  end

  def search_by_category(category)
    study_objects = []
    dao = StudyDao.new
    dao.select_by_category(category).each do |item|
      study_objects << StudyItem.new(item[0], item[1], category, item[2], item[3])
    end
    study_objects
  end

  def delete_item(id)
    dao = StudyDao.new
    dao.delete_item(id)
  end

  def mark_as_done(title, category)

  end
end
