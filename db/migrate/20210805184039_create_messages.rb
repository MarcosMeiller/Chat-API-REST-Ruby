class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.string :polarity
      t.boolean :is_edited, default: false
      t.boolean :is_deleted, default: false
      t.boolean :is_censored, default: false
      t.references :chat, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
