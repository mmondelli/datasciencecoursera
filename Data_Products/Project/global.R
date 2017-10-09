library(shiny)
library(ggplot2)
library(RPostgreSQL)
library(sqldf)
library(formattable)
library(RColorBrewer)
library(shinydashboard)
library(DT)
library(plyr)
library(dplyr)
library(reshape)
library(lubridate)
library(scales)
library(anytime)
library(shinyjs)

clrs <- c('#1FC3EA', '#3DFAFF', '#FFA400', '#6EEB83', '#E4FF1A')

blf.df <- read.csv('./Data/banda_larga_fixa2.csv', 
                   header=T, sep=';',
                   fileEncoding = "UTF-8")
nrow(blf.df) #42206
ncol(blf.df) #8
names.blf <- colnames(blf.df)

companies <- unique(blf.df$OPERADORA); companies
states <- unique(as.character(blf.df$ESTADO))
states <- states[-3]
topic <- unique(blf.df$TEMA)