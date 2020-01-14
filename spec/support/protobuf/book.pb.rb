# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'
require 'protobuf/rpc/service'


##
# Imports
#
require 'error.pb'

module Generic
  module Remote
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class Book < ::Protobuf::Message; end
    class Books < ::Protobuf::Message; end
    class BookRequest < ::Protobuf::Message; end


    ##
    # Message Fields
    #
    class Book
      optional :string, :guid, 1
      optional :string, :author_guid, 2
      optional :string, :name, 3
      optional :string, :kind, 4
      optional :string, :status, 5
      optional :string, :read_status, 6
      optional :string, :nullable_status, 7
      optional :string, :language, 8
      optional :string, :author_visibility, 9
      optional :string, :illustrator_visibility, 10
      optional :string, :font_size, 11
      optional :string, :difficulty, 12
      optional :string, :cover, 13
      optional :bool, :boolean_status, 14
    end

    class Books
      repeated ::Generic::Remote::Book, :records, 1
    end

    class BookRequest
      repeated :string, :guid, 1
      repeated :string, :name, 2
      repeated :string, :kind, 3
      repeated :string, :status, 4
      repeated :string, :read_status, 5
      repeated :string, :nullable_status, 6
      repeated :string, :language, 7
      repeated :string, :author_visibility, 8
      repeated :string, :illustrator_visibility, 9
      repeated :string, :font_size, 10
      repeated :string, :difficulty, 11
      repeated :string, :cover, 12
      repeated :bool, :boolean_status, 13
    end


    ##
    # Service Classes
    #
    class BookService < ::Protobuf::Rpc::Service
      rpc :search, ::Generic::Remote::BookRequest, ::Generic::Remote::Books
      rpc :create, ::Generic::Remote::Book, ::Generic::Remote::Book
      rpc :update, ::Generic::Remote::Book, ::Generic::Remote::Book
      rpc :delete, ::Generic::Remote::Book, ::Generic::Remote::Book
      rpc :create_all, ::Generic::Remote::Books, ::Generic::Remote::Books
      rpc :update_all, ::Generic::Remote::Books, ::Generic::Remote::Books
      rpc :delete_all, ::Generic::Remote::Books, ::Generic::Remote::Books
      rpc :destroy_all, ::Generic::Remote::Books, ::Generic::Remote::Books
    end

  end

end

