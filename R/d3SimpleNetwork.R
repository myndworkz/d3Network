#' Function for creating simple D3 JavaScript force directed network graphs.
#'
#' \code{d3SimpleNetwork} creates simple D3 JavaScript force directed network graphs.
#'
#' @param Data a data frame object with three columns. The first two are the names of the linked units. The third records an edge value. (Currently the third column doesn't affect the graph.)
#' @param Source character string naming the network source variable in the data frame. If \code{Source = NULL} then the first column of the data frame is treated as the source.
#' @param Target character string naming the network target variable in the data frame. If \code{Target = NULL} then the second column of the data frame is treated as the target.
#' @param height numeric height for the network graph's frame area in pixels.
#' @param width numeric width for the network graph's frame area in pixels.
#' @param fontsize numeric font size in pixels for the node text labels.
#' @param linkDistance numeric distance between the links in pixels (actually arbitrary relative to the diagram's size).
#' @param charge numeric value indicating either the strength of the node repulsion (negative value) or attraction (positive value).
#' @param linkColour character string specifying the colour you want the link lines to be. Multiple formats supported (e.g. hexadecimal).
#' @param nodeColour character string specifying the colour you want the node circles to be. Multiple formats supported (e.g. hexadecimal).
#' @param nodeClickColour character string specifying the colour you want the node circles to be when they are clicked. Also changes the colour of the text. Multiple formats supported (e.g. hexadecimal).
#' @param textColour character string specifying the colour you want the text to be before they are clicked. Multiple formats supported (e.g. hexadecimal).
#' @param opacity numeric value of the proportion opaque you would like the graph elements to be.
#' @param standAlone logical, whether or not to return a complete HTML document (with head and foot) or just the script.
#' @param file a character string of the file name to save the resulting graph. If a file name is given a standalone webpage is created, i.e. with a header and footer. If \code{file = NULL} then result is returned to the console. 
#' @param iframe logical. If \code{iframe = TRUE} then the graph is saved to an external file in the working directory and an HTML \code{iframe} linking to the file is printed to the console. This is useful if you are using Slidify and many other HTML slideshow framworks and want to include the graph in the resulting page. If you set the knitr code chunk \code{results='asis'} then the graph will be rendered in the output. Usually, you can use \code{iframe = FALSE} if you are creating simple knitr Markdown or HTML pages. Note: you do not need to specify the file name if \code{iframe = TRUE}, however if you do, do not include the file path.
#' @param d3Script a character string that allows you to specify the location of the d3.js script you would like to use. The default is \url{http://d3js.org/d3.v3.min.js}.
#'
#' @examples
#' # Fake data
#' Source <- c("A", "A", "A", "A", "B", "B", "C", "C", "D")
#' Target <- c("B", "C", "D", "J", "E", "F", "G", "H", "I")
#' NetworkData <- data.frame(Source, Target)
#' 
#' # Create graph
#' d3SimpleNetwork(NetworkData, height = 300, width = 700, 
#'                  fontsize = 15)
#'
#' @source 
#' D3.js was created by Michael Bostock. See \url{http://d3js.org/} and, more specifically for directed networks \url{https://github.com/mbostock/d3/wiki/Force-Layout}
#' 
#' @importFrom whisker whisker.render
#' 
#' @export

d3SimpleNetwork <- function(Data, Source = NULL, Target = NULL, height = 600, width = 900, fontsize = 7, linkDistance = 50, charge = -200, linkColour = "#666", nodeColour = "#3182bd", nodeClickColour = "#E34A33", textColour = "#3182bd", opacity = 0.6, standAlone = TRUE, file = NULL, iframe = FALSE, d3Script = "http://d3js.org/d3.v3.min.js")
{
  if (!isTRUE(standAlone) & isTRUE(iframe)){
    stop("If iframe = TRUE then standAlone must be TRUE.")
  }
  # If no file name is specified create random name to avoid conflicts
  if (is.null(file) & isTRUE(iframe)){
    Random <- paste0(sample(c(0:9, letters, LETTERS), 5, replace=TRUE), collapse = "")
    file <- paste0("NetworkGraph", Random, ".html")
  }
  
  # Create iframe dimensions larger than graph dimensions
  FrameHeight <- height + height * 0.07
  FrameWidth <- width + width * 0.03

  # Create click text size
  clickTextSize <- fontsize * 2.5

  # Subset data frame for network graph
  if (class(Data) != "data.frame"){
    stop("Data must be a data frame class object.")
  }
  
  if (is.null(Source) & is.null(Target)){
    NetData <- Data[, 1:2]
  }
  else if (!is.null(Source) & !is.null(Target)){
    NetData <- data.frame(Data[, Source], Data[, Target])
  }
  names(NetData) <- c("source", "target")
  
  # Convert data frame to JSON format
  LinkData <- toJSONarray(NetData)
  LinkData <- paste("var links =", LinkData, "; \n")
  
  # Create webpage
  PageHead <- "
  <!DOCTYPE html> 
  <meta charset=\"utf-8\">
  <body> \n"
  
  # Create Style Sheet
  NetworkCSS <- whisker.render(BasicStyleSheet())
  
  # Main script for creating the graph
  MainScript <- whisker.render(BasicForceJS())
  
  if (is.null(file) & !isTRUE(standAlone)){
    cat(NetworkCSS, LinkData, MainScript)
  } 
  else if (is.null(file) & isTRUE(standAlone)){
    cat(PageHead, NetworkCSS, LinkData, MainScript, 
        "</body>")
  } 
  else if (!is.null(file) & !isTRUE(standAlone)){
    cat(NetworkCSS, LinkData, MainScript, file = file)
  }
  else if (!is.null(file) & !isTRUE(iframe)){
    cat(PageHead, NetworkCSS, LinkData, MainScript, 
        "</body>", file = file)
  }
  else if (!is.null(file) & isTRUE(iframe)){
    cat(PageHead, NetworkCSS, LinkData, MainScript, 
        "</body>", file = file)
    cat("<iframe src=\'", file, "\'", " height=", FrameHeight, " width=", FrameWidth, 
        "></iframe>", sep="")  
  }
}