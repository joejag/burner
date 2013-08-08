var BurnUp = {
    create_burnup_graph: function(chart_element, y_axis_element, legend_element, project) {
        $.getJSON('/project/' + project + '/data', function(data) {
            var palette = new Rickshaw.Color.Palette()
            $(data).each(function(index) { data[index].color = palette.color(index * 3) })

            var graph = new Rickshaw.Graph( {
                element: chart_element,
                width: 800,
                height: 500,
                renderer: 'line',
                series: data,
            })

            new Rickshaw.Graph.Axis.Time( {
                graph: graph,
                timeUnit: (new Rickshaw.Fixtures.Time()).unit('month')
            })

            new Rickshaw.Graph.Axis.Y( {
                graph: graph,
                element: y_axis_element,
                orientation: 'left',
                tickFormat: Rickshaw.Fixtures.Number.formatKMBT,
            })

            new Rickshaw.Graph.Legend( {
                graph: graph,
                element: legend_element,
            })

            new Rickshaw.Graph.HoverDetail({
              graph: graph
            })

            graph.render()
        })
    }
}
