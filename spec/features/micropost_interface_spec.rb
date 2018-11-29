require 'rails_helper'
require 'supports/micropost_helper'

feature "MicropostInterfaceTest" ,type: :feature do
  let(:user){create(:user)}
  let(:microposts){create_list(:micropost,50,user:user)}
  let(:other_user){create(:other_user)}
  let(:other_microposts){create_list(:other_micropost,50,user:other_user)}
  before{microposts}
  scenario 'post micropost then delete' do
    visit login_path
    login_in_capy(user)
    click_on 'Home'
    expect(page).to have_selector('div.pagination')
    expect{post_micropost("")}.to_not change{Micropost.count}
    expect(page).to have_css('div#error_explanation')
    expect{post_micropost("content")}.to change{Micropost.count}.from(Micropost.count).to(Micropost.count+1)
    expect(current_path).to eq(root_path)
    expect(page).to have_text('content')


    expect(page).to have_selector('a',text: 'delete')
    expect{ first('ol li').click_link 'delete'}.to change{Micropost.count}.from(Micropost.count).to(Micropost.count-1)
  end

  scenario 'other users micropost have no delete link' do
    other_microposts
    visit login_path
    login_in_capy(user)
    visit user_path(other_user)
    expect(page).to_not have_selector('a',text:'delete')
  end

  scenario 'micropost sidebar count' do
    visit login_path
    login_in_capy(user)
    click_on 'Home'
    expect(page).to have_selector('span',text:"#{user.microposts.count} microposts")

    other_user = create(:other_user)
    visit login_path
    login_in_capy(other_user)
    click_on 'Home'
    expect(page).to have_selector('span', text: "0 micropost")
    other_user.microposts.create!(content: "new content")
    click_on 'Home'
    expect(page).to have_selector('span', text: '1 micropost')
  end
end