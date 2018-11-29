def post_micropost(content)
  fill_in 'micropost', with: content
  click_on 'Post'
end