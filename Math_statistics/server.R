
shinyServer(function(input, output) {

    react <- reactive({
        
    })
    
    
    output$home <- renderUI({
        includeMarkdown("home.Rmd")
    })    
    output$formula <- renderUI({
        withMathJax(includeMarkdown("formula.Rmd"))
    })
    output$appendix <- renderUI({
        includeMarkdown("appendix.Rmd")
    })
    
})
