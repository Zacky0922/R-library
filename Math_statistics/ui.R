#    http://shiny.rstudio.com/

# functions
# RmdファイルにMathJaxを適用して読み込む
getRmd <- function(Rmd) {
    withMathJax(includeMarkdown(Rmd))
}

getRmd2 <- function(Rmd){

    renderUI({
        k <- knit(input = Rmd, quiet = T)
        HTML(markdownToHTML(k, fragment.only = T))
    })
}

# 指定タブを開く
getTabLink <- function(tab) {
    return(gsub(" ", "", paste("#shiny-tab-", tab)))
    # gsub で空白除去
}


# データの分析


####    navbarPage    ####

# navLayout <- navbarPage(
#     title = "統計の基礎",
#     tabPanel("Home", uiOutput("home"), icon = icon("home")),
#     tabPanel("データの分析"),
#     # tabPanel("確率"),
#     # tabPanel("確率と統計"),
#     # tabPanel("統計の基礎"),
#     # tabPanel("公式集", uiOutput("formula")),
#     # tabPanel("練習問題"),
#     # tabPanel("data"),
#     tabPanel("おまけ", uiOutput("appendix"))
#
#     # 各種設定
#     # メニュー位置
#     #position = "fixed-top",
#     # 小画面でメニュー格納
#     #collapsible = TRUE,
#     # ダークモード（CSSによって上書きされる場合有）
#     #inverse = TRUE
#     # CSS
#     # theme = shinytheme("yeti")
#
#     #tags$head(tags$style("@import 'style.css';")),
#     #includeCSS("www/style.css")
#     # JS loadしてる？
#     # includeScript("https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js?lang=r")
# )




####  main frame  ####

mainFr <- dashboardPage(
    dashboardHeader(title = "統計の基礎"),
    dashboardSidebar(sidebarMenu(
        menuItem("Home", icon = icon("home"), tabName = 'tab_home'),
        menuItem("Home", icon = icon("home"), tabName = 'tab_home2'),
        menuItem(
            "データの分析",
            icon = icon("chart-bar"),
            menuSubItem("基本事項", tabName = "tab_01-01"),
            menuSubItem("データの要約", tabName = "tab_01-02"),
            menuSubItem("データの散らばり", tabName = "tab_01-03"),
            menuSubItem("まとめ", tabName = "tab_01-summary")
        ),
        menuItem(
            "2次元データ",
            icon = icon("table"),
            menuSubItem("データの散らばり", tabName = "tab_02-01"),
            menuSubItem("まとめ", tabName = "tab_02-summary")
        ),
        menuItem("Appendix", icon = icon("star"), tabName = 'tab_appendix')
    )),
    dashboardBody(
        tabItems(
            # リンクに関するバグがあるので、ラッパー作ってどうにかしたい
            tabItem("tab_home",
                    fluidRow(
                        a(
                            href = getTabLink("tab_01-01"),
                            valueBox(
                                "データの分析",
                                "数学I範囲",
                                icon = icon("chart-bar"),
                                width = 6
                            ),
                            "data-toggle" = "tab"
                        ),
                        a(
                            href = getTabLink("tab_02-01"),
                            valueBox(
                                "2次元データ",
                                "数学I範囲",
                                icon = icon("table"),
                                width = 6
                            ),
                            "data-toggle" = "tab"
                        )
                    ),
                    getRmd("home.Rmd")),
            #tabItem("tab_home2", getRmd2("home.Rmd")),
            tabItem("tab_01-01", getRmd("01_DataAnalytics/01_basics.Rmd")),
            tabItem("tab_01-02", getRmd("01_DataAnalytics/02_summarize.Rmd")),
            tabItem("tab_01-03", getRmd("01_DataAnalytics/03_variance.Rmd")),
            tabItem("tab_01-summary", getRmd("01_DataAnalytics/summary.Rmd")),
            tabItem("tab_appendix", getRmd("appendix.Rmd")),
            tabItem("tab_02-01", getRmd("02_2Ddata/01_variance.Rmd")),
            tabItem("tab_02-summary", getRmd("02_2Ddata/summary.Rmd"))
        )
    ),
    skin = "blue"
)


shinyUI(mainFr)