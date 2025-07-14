class CreateStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :course
      t.string :year

      t.timestamps
    end
  end
end
