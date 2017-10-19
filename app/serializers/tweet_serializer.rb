require "action_view"

class TweetSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes :created_at, :text

  def created_at
    Time.use_zone object.time_zone || "Brasilia" do
      time_ago_in_words object.created_at.dup
    end
  end
end
