class CreateTasks < ActiveRecord::Migration[8.1] # ou a versão que estiver
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status, default: 0 # 0 será 'pending'
      t.string :url
      t.jsonb :result
      t.text :error_message
      t.integer :user_id

      t.timestamps
    end
  end
end