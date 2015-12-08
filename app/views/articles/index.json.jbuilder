json.array!(@articles) do |article|
  json.extract! article, :id, :title, :descriptoin
  json.url article_url(article, format: :json)
end
