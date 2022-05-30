## Some utility functions in R
## Author: Qi Sun
## Date: 2022/05/13

library(R6)

## This is the util class for loading R packages
## example: 
## obj <- Pack$new()
## Pack$new("ggplot2", "R6")
## Pack$new(c("ggplot2", "R6"))
## obj <- Pack$new(list("ggplot2", "R6"))
## private attributes: t$pack_list
## public methods:
## t$load_pack("package name")
## t$show_pack()
## t$show_pack_version()
Pack <- R6Class("Pack",
                private = list(pack_list = NULL),
                public = list(
                    initialize = function(...) {
                        args <- list(...)
                        private$pack_list <- library()$results[,1]
                        for (arg in args) lapply(arg, self$load_pack)
                    },
                    load_pack = function(p) {
                        ## if (!is.element(p, private$pack_list[, "Package"])) install.packages(p)
                        if (!is.element(p, private$pack_list)) install.packages(p)
                        else print(paste(p, "already exists..."))
                        require(p, character.only = TRUE)
                    },
                    show_pack = function() print(private$pack_list),
                    show_pack_version = function() {
                        ## show all the installed packages with version
                        raw <- as.data.frame(installed.packages()[,c(1,3:4)])
                        df <- raw[is.na(raw$Priority),1:2,drop=FALSE]
                        rownames(df) <- NULL
                        print(df)
                    }
                )
                )

## This is the util class for plots
## we save the final plot in ./.png
## library(ggplot2)
## data("midwest", package = "ggplot2")
## ggplot(midwest, aes(x=area, y=poptotal))
