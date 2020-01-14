require "spec_helper"

describe ::ActiveRemote::Enum do
  let(:book_fixtures) {
    {
      awdr: {
        author_guid: "1",
        guid: "123abc-1",
        name: "Agile Web Development with Rails",
        kind: "paperback",
        status: :published,
        read_status: :read,
        language: :english,
        author_visibility: :visible,
        illustrator_visibility: :visible,
        font_size: :medium,
        difficulty: :medium,
        boolean_status: :enabled
      },
      rfr: {
        author_guid: "1",
        guid: "123abc-2",
        name: "Ruby for Rails",
        kind: "ebook",
        status: "proposed",
        read_status: "reading"
      },
      ddd: {
        author_guid: "1",
        guid: "123abc-3",
        name: "Domain-Driven Design",
        kind: "hardcover",
        status: 2,
        read_status: "forgotten"
      },
      tlg: {
        author_guid: "1",
        guid: "123abc-4",
        name: "Thoughtleadering"
      },
      cat: {
        author_guid: "1",
        guid: "123abc-4",
        name: "Complicated Angry Turtles",
        status: :published
      }
    }
  }

  let(:book) { books[:awdr] }
  let(:books) do
    {
      awdr: Book.new(book_fixtures[:awdr]),
      rfr: Book.new(book_fixtures[:rfr]),
      ddd: Book.new(book_fixtures[:ddd]),
      tlg: Book.new(book_fixtures[:tlg])
    }
  end

  let(:response_without_errors) { ::HashWithIndifferentAccess.new(:errors => []) }
  let(:rpc) { double(:rpc) }

  before {
    allow(rpc).to receive(:execute).and_return(response_without_errors)
    allow(Book).to receive(:rpc).and_return(rpc)
  }
  after { allow(::Book).to receive(:rpc).and_call_original }

  describe "query state by predicate" do
    it { expect(book.published?).to eq true }
    it { expect(book.written?).to eq false }
    it { expect(book.proposed?).to eq false }
    it { expect(book.read?).to eq true }
    it { expect(book.in_english?).to eq true }
    it { expect(book.author_visibility_visible?).to eq true }
    it { expect(book.illustrator_visibility_visible?).to eq true }
    it { expect(book.with_medium_font_size?).to eq true }
    it { expect(book.medium_to_read?).to eq true }
  end

  describe "query state with strings" do
    it { expect(book.status).to eq "published" }
    it { expect(book.read_status).to eq "read" }
    it { expect(book.language).to eq "english" }
    it { expect(book.author_visibility).to eq "visible" }
    it { expect(book.illustrator_visibility).to eq "visible" }
    it { expect(book.difficulty).to eq "medium" }
  end

  describe "find via scope" do
    let(:records) { [book] }
    before { allow(Book).to receive(:search).and_return(records) }

    it { expect(book).to eq Book.published.first }
    it { expect(book).to eq Book.read.first }
    it { expect(book).to eq Book.in_english.first }
    it { expect(book).to eq Book.author_visibility_visible.first }
    it { expect(book).to eq Book.illustrator_visibility_visible.first }
    # it { expect(book).to eq Book.medium_to_read.first } # TODO: support x_to_y scopes
    # it { expect(books[:ddd]).to eq Book.forgotten.first } # TODO: consider dropping this - it's the same spec as "Book.read.first"
    # it { expect(books[:rfr]).to eq authors[:david].unpublished_books.first } # NOTE: scopes as associations not supported
  end

  # TODO: the rest of the test seen at:
  # https://github.com/rails/rails/blob/master/activerecord/test/cases/enum_test.rb


end
