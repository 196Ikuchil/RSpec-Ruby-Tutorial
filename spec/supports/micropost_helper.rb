def post_micropost(content,image: image=nil)
  fill_in 'micropost', with: content
  if !image.nil?
    attach_file "micropost[picture]", image
  end
  click_on 'Post'
end