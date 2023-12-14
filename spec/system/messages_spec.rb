require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user)
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗する' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # DBに保存されていないことを確認する
      expect{
        click_on('送信')
        # find('input[name="commit"]').click
      }.to change{ Message.count }.by(0)
      # }.to_not change{ Message.count }

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する
      message = FactoryBot.build(:message)
      fill_in 'message_content', with: message.content
      
      # 送信した値がDBに保存されていることを確認する
      expect{
        click_on('送信')
        sleep 1
      }.to change{ Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(message.content)
    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)

      # 送信した値がDBに保存されていることを確認する
      expect{
        # click_on('送信')
        find('input[name="commit"]').click
        sleep 1
    }.to change{ Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
    end

    it 'テキストと画像の投稿に成功する' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png') # Rails.rootで、プロジェクト直下までのパスを取得できる

      # 画像選択フォームに画像を添付する
      # fileのinput要素のname属性を指定する
      attach_file('message[image]', image_path, make_visible: true)

      # 値をテキストフォームに入力する
      message = FactoryBot.build(:message)
      fill_in 'message_content', with: message.content

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change{Message.count}.by(1)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(message.content)
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')

      # 投稿した要素が表示されている = 一覧ページに遷移できているということになるので
      # 現在のpathの確認は行わなくてよい
    end
  end
end