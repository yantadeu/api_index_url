class PaginaWeb
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::FullTextSearch

  field :url_scrap, type: String
  field :url, type: String
  field :keywords, type: String
  field :host, type: String
  field :root_url, type: String
  field :scheme, type: String
  field :title, type: String
  field :description, type: String
  field :content, type: String
  field :links, type: Array
  field :meta_tags, type: Hash
  field :head_links, type: Array
  field :stylesheets, type: Array
  field :canonicals, type: Array

  validates_presence_of :url, :title, :scheme

  fulltext_search_in :keywords, :url, :title, :description, :content
  
  def from_page(page, content, search_url)
    self.url_scrap = search_url
    self.url = page.url
    self.host = page.host
    self.title = page.title
    self.keywords = page.meta_tag['name'] ? page.meta_tag['name']['keywords'] : ''
    self.description = page.description
    self.root_url = page.root_url
    self.scheme = page.scheme
    self.content = content
    self.links = page.links.raw
    self.meta_tags = page.meta_tags
    self.head_links = page.head_links
    self.stylesheets = page.stylesheets
    self.canonicals = page.canonicals
  end

end
