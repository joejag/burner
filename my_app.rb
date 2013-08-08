class MyApp < Sinatra::Base
    register Sinatra::Reloader

    get "/" do
        @projects = ProjectStatus.select(:project).distinct.map(&:project)
        erb :index
    end

    get "/project/:name" do
        @name = params[:name]
        erb :project
    end

    get "/project/:project/data" do
        content_type :json
        Parser.new(params[:project]).lines.to_json
    end

    post "/update" do
      @status = ProjectStatus.new(params[:project_status])
      if @status.save
          "Fine"
      else
          "Nope!"
      end
    end

    get "/data_dump" do
        @data = ProjectStatus.all
        @data.to_json
    end

end
