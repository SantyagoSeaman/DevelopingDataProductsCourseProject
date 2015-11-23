library(shiny)

shinyUI(pageWithSidebar(
    headerPanel('Iris dataset: Fitting Generalized Linear Models'),
    sidebarPanel(
        h4("Select predictors:"),
        checkboxInput(inputId = "Sepal.Length",
                      label = strong("Sepal.Length"),
                      value = TRUE),

        checkboxInput(inputId = "Sepal.Width",
                      label = strong("Sepal.Width"),
                      value = TRUE),

        checkboxInput(inputId = "Petal.Length",
                      label = strong("Petal.Length"),
                      value = FALSE),

        checkboxInput(inputId = "Petal.Width",
                      label = strong("Petal.Width"),
                      value = FALSE),

        selectInput(inputId = "lmInteraction",
                    label = "GLM predictors interaction:",
                    choices = c("without interaction", "with interaction"),
                    selected = "without interaction")
    ),
    mainPanel(
        p('This application was developed in accordance with requirements of Coursera Developing Data Products course.'),
        p('There is you have opportunities to select predictors of standard Iris dataset, select predictors interaction type and application will make fittin of GLM model and prediction.'),
        p('Additionaly you can see residuals plots and two plots with correlation matrixes.'),
        h3('GLM Summary'),
        verbatimTextOutput('lmSummarize'),
        h3('GLM Residuals'),
        plotOutput('plot2', height = "800px"),
        h3('Correlation matrix'),
        plotOutput('plot3', height = "800px"),
        h3('Funny correlation matrix :)'),
        plotOutput('plot1')
    )
))
