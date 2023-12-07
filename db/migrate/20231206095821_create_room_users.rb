class CreateRoomUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :room_users do |t|
      # 外部キーのカラムを追加する際に用いる型, references
      # 外部キーを指定することで、必ず存在している必要が出てくる
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
