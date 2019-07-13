class CreateRhetoricSpeakers < ActiveRecord::Migration[5.2]
  def change
    create_table :rhetoric_speakers do |t|
      t.integer :speaker_id
      t.integer :rhetoric_id

      t.timestamps
    end
    add_index :rhetoric_speakers, :speaker_id
    add_index :rhetoric_speakers, :rhetoric_id
    add_index :rhetoric_speakers, [:rhetoric_id,:speaker_id],unique: true
  end
end
