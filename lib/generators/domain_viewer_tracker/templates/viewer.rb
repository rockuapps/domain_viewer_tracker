# == Schema Information
#
# Table name: viewers
#
#  id         :integer          not null, primary key
#  uuid       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_viewers_on_uuid_and_user_id  (uuid,user_id) UNIQUE
#

class Viewer < ActiveRecord::Base
end
