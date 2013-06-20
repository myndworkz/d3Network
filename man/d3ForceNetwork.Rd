\name{d3ForceNetwork}
\alias{d3ForceNetwork}
\title{Create a D3 JavaScript force directed network graph.}
\source{
  D3.js was created by Michael Bostock. See
  \url{http://d3js.org/} and, more specifically for
  directed networks
  \url{https://github.com/mbostock/d3/wiki/Force-Layout}
}
\usage{
  d3ForceNetwork(Links, Nodes, Source, Target,
    Value = NULL, NodeID, Group, height = 600, width = 900,
    standAlone = TRUE, file = NULL, iframe = FALSE)
}
\arguments{
  \item{Links}{a data frame object with the links between
  the nodes. It should have include the \code{Source} and
  \code{Target} for each link. An optional \code{Value}
  variable can be included to specify how close the nodes
  are to one another.}

  \item{Nodes}{a data frame containing the node id and
  properties of the nodes. If no ID is specified then the
  nodes must be in the same order as the Source variable
  column in the \code{Links} data frame. Currently only a
  grouping variable is allowed.}

  \item{Source}{character string naming the network source
  variable in the \code{Links} data frame.}

  \item{Target}{character string naming the network target
  variable in the \code{Links} data frame.}

  \item{Value}{character string naming the variable in the
  \code{Links} data frame for how far away the nodes are
  from one another.}

  \item{NodeID}{character string specifying the node IDs in
  the \code{Nodes} data frame.}

  \item{Group}{character string specifying the group of
  each node in the \code{Nodes} data frame.}

  \item{height}{numeric height for the network graph's
  frame area in pixels.}

  \item{width}{numeric width for the network graph's frame
  area in pixels.}

  \item{standAlone}{logical, whether or not to return a
  complete HTML document (with head and foot) or just the
  script.}

  \item{file}{a character string of the file name to save
  the resulting graph. If a file name is given a standalone
  webpage is created, i.e. with a header and footer. If
  \code{file = NULL} then result is returned to the
  console.}

  \item{iframe}{logical. If \code{iframe = TRUE} then the
  graph is saved to an external file in the working
  directory and an HTML \code{iframe} linking to the file
  is printed to the console. This is useful if you are
  using Slidify and many other HTML slideshow framworks and
  want to include the graph in the resulting page. If you
  set the knitr code chunk \code{results='asis'} then the
  graph will be rendered in the output. Usually, you can
  use \code{iframe = FALSE} if you are creating simple
  knitr Markdown or HTML pages. Note: you do not need to
  specify the file name if \code{iframe = TRUE}, however if
  you do, do not include the file path.}
}
\description{
  Create a D3 JavaScript force directed network graph.
}
