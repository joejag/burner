class Parser

    def initialize project
      @scoped_data = []
      @done_data = []
      _parse_project(project)
    end

    def lines
      [ scope_line, done_line, scope_trend_line, done_trend_line]
    end

    def scope_line
      {name: 'Scoped', data: @scoped_data }
    end

    def done_line
      {name: 'Done', data: @done_data }
    end

    def scope_trend_line
      {name: 'Scope Trend', data: [
          {x: @scoped_data.first[:x], y: @scoped_data.first[:x] * analyzed_scope_line.slope + analyzed_scope_line.y_intercept},
          analyzed_intersection_point
      ]}
    end

    def done_trend_line
      {name: 'Done Trend', data: [
          {x: @done_data.first[:x], y: @done_data.first[:x] * analyzed_done_line.slope + analyzed_done_line.y_intercept},
          analyzed_intersection_point
      ]}
    end

    def analyzed_intersection_point
        {x: SimpleLinearRegression.get_x_intersection(analyzed_scope_line, analyzed_done_line).to_i,
         y: SimpleLinearRegression.get_y_intersection(analyzed_scope_line, analyzed_done_line).to_i}
    end

    def analyzed_scope_line
      x_points = @scoped_data.map {|e| e[:x]}
      y_points = @scoped_data.map {|e| e[:y]}
      SimpleLinearRegression.new(x_points, y_points)
    end

    def analyzed_done_line
      x_points = @done_data.map {|e| e[:x]}
      y_points = @done_data.map {|e| e[:y]}
      SimpleLinearRegression.new(x_points, y_points)
    end

    def _parse_project project
      ProjectStatus.where(project: project).each do |status|
        @scoped_data << {x: status.status_at.to_i, y: status.scoped}
        @done_data << {x: status.status_at.to_i, y: status.done}
      end
    end

end
