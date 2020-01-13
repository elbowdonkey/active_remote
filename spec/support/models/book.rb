class Book < ::ActiveRemote::Base
  #service_class ::Generic::Remote::BookService

  attribute :guid
  attribute :author_guid
  attribute :name
  attribute :kind

  enum status: [:proposed, :written, :published]
  enum read_status: { unread: 0, reading: 2, read: 3, forgotten: nil }
  enum nullable_status: [:single, :married]
  enum language: [:english, :spanish, :french], _prefix: :in
  enum author_visibility: [:visible, :invisible], _prefix: true
  enum illustrator_visibility: [:visible, :invisible], _prefix: true
  enum font_size: [:small, :medium, :large], _prefix: :with, _suffix: true
  enum difficulty: [:easy, :medium, :hard], _suffix: :to_read
  enum cover: { hard: "hard", soft: "soft" }
  enum boolean_status: { enabled: true, disabled: false }
end
