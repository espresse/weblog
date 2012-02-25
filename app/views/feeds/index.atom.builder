atom_feed :language => 'en' do |feed|
  feed.title(@title)

  feed.updated(@updated)

  @posts.each do |post|
    feed.entry(post, :published => post.created_at) do |entry|

      entry.title(h(post.title))
      entry.summary(truncate(strip_tags(post.content), :length => 200))

      entry.author do |author|
        author.name(post.user.username)
      end
    end
  end
end
