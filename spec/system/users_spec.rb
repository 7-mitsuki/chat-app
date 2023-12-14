require 'rails_helper'
# 結合テストでは、最終的にどのページにいるか？で成否を判定することもある

# ユーザーのログイン成功/失敗時の動きに着目
RSpec.describe 'ユーザーログイン機能', type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)
    # expect(current_path).to eq(new_user_session_path)
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインインページへ移動する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンをクリックする
    click_on('Log in')
    # find("input[name='commit']").click
    sleep 1
    # トップページに遷移していることを確認する
    expect(page).to have_current_path(root_path)
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)
    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: 'test'
    fill_in 'user_password', with: 'test'
    # ログインボタンをクリックする
    click_on('Log in')
    sleep 1
    # サインインページに戻ってきていることを確認する
    expect(page).to have_current_path(new_user_session_path)
  end
end
