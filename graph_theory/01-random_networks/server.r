library(shiny)
library(igraph)

shinyServer(function(input, output) {
    # For now, set the seed to 1 (later can parameterize)
    set.seed(1)

    # Create starting network and store node coordinates
    x = matrix(sample(0:1, 100, replace=TRUE), 10, 10)
    coords = layout.auto(graph.adjacency(x))

    # Generate plot
    # @TODO show adj matrix grid (e.g. gray/organge cells)
    output$random_net <- renderPlot({
        z = matrix(rbinom(100, size=1, prob=input$degree/10), 10, 10)
        plot(graph.adjacency(z), layout=coords)
    },
    height=800, width=800)
})
