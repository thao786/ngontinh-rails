class Chapter < ActiveRecord::Base
  belongs_to :fiction

  def to_param
    chapnum
  end
end
