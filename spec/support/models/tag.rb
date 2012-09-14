require 'support/protobuf/tag_service'

##
# Define a generic class that inherits from active remote base
#
class Tag < ::ActiveRemote::Base
  service_class ::Generic::Remote::TagService

  attr_accessor :guid, :name

end
