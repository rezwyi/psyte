Fabricator(:post) do
	title 'Some title'
  body '##Some body'
  published_at Time.now - 1.day
end