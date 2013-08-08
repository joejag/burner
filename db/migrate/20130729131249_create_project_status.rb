class CreateProjectStatus < ActiveRecord::Migration

  def change
    create_table :project_statuses do |t|
      t.string :project
      t.string :team
      t.integer :done
      t.integer :scoped
      t.datetime :status_at
    end
  end

end
