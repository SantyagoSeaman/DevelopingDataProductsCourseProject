library(shiny)
library(corrplot)
library(PerformanceAnalytics)

shinyServer(function(input, output, session) {

    # Combine the selected variables into a new data frame
    selectedData <- reactive({
        predictors <- c('Species')
        if (as.integer(input$Sepal.Length) > 0) {
            predictors <- c(predictors, 'Sepal.Length')
        }
        if (as.integer(input$Sepal.Width) > 0) {
            predictors <- c(predictors, 'Sepal.Width')
        }
        if (as.integer(input$Petal.Length) > 0) {
            predictors <- c(predictors, 'Petal.Length')
        }
        if (as.integer(input$Petal.Width) > 0) {
            predictors <- c(predictors, 'Petal.Width')
        }
        iris[, predictors]
    })

    clusters <- reactive({
        #kmeans(selectedData()[-1], input$clusters)
        data <- selectedData()
        cdplot(lmFormula(), data)
    })

    lmFormula <- reactive({
        data <- selectedData()
        interaction <- ' + '
        if (input$lmInteraction == 'with interaction') {
            interaction <- ' * '
        }
        formula(paste('Species ~ ', paste(names(data)[-1], collapse = interaction), sep = ''))
    })

    lmModel <- reactive({
        glm(lmFormula(), selectedData(), family="binomial")
    })

    output$plot1 <- renderPlot({
        data <- selectedData()
        data$Species <- as.integer(data$Species)
        corrplot(cor(data))
    })

    output$plot2 <- renderPlot({
        par(mfrow=c(2,2))
        plot(lmModel())
    })

    output$plot3 <- renderPlot({
        data <- selectedData()
        data$Species <- as.integer(data$Species)
        chart.Correlation(data, histogram=TRUE, pch=19)
    })

    output$lmSummarize <- renderPrint({
        lmModel()
    })

})
