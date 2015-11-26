# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  effect      :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


#TODO: Remodelar Items para que use la tabla intermedia. De todos modos siempre fue necesario una lista de items.
class Item < ActiveRecord::Base
      belongs_to :user

      validates :name, presence: true, uniqueness: true
end
