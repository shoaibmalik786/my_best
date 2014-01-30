class UsernamesController < ApplicationController
  respond_to :json

  def check
    form = UsernameDummyForm.new(Username.new)
    valid = form.validate(params)
    error = form.errors.full_messages.first
    respond_with "{\"valid\":\"#{valid}\",\"error\":\"#{error}\"}"
  end

  private

  class UsernameDummyForm < Reform::Form
    include Reform::Form::ActiveRecord

    model :username

    property :username, type: String
    validates :username, username: true
    validates_uniqueness_of :username
  end
end
