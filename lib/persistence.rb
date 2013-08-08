class ProjectStatus < ActiveRecord::Base
    validates_presence_of :project, :team, :done, :scoped, :status_at
end
