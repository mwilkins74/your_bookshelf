# frozen_string_literal: true

require 'dry-initializer'

class NavbarComponent < ViewComponent::Base
  extend Dry::Initializer

  option :logged_in, default: -> { false }
  option :current_user, default: -> { nil }
end
