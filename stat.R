library(ggplot2)
library(dplyr)
library(plotly)
library(tibble)
library(bs4Dash)
remotes::install_github("deepanshu88/summaryBox")
library(summaryBox)

#### Just to test a few things
setwd("C:/Users/gabri/Desktop/Training/R/Bank_Dashboard")

data = read.csv("bank-full.csv", header = TRUE, sep = ';')

head(data)

str(data)

#data %>% count(education, sort = TRUE)
data %>% count(job, sort = TRUE)
#data %>% count(age, sort = TRUE)
#data %>% count(marital, sort = TRUE)
#data %>% count(default, sort = TRUE)
#data %>% count(housing, sort = TRUE)
#data %>% count(loan, sort = TRUE)
#data %>% count(contact, sort = TRUE)
#data %>% count(month, sort = TRUE)
#data %>% count(poutcome, sort = TRUE)
#data %>% count(balance, sort = TRUE)

names(data)

education_colors <- c()
job_colors <- c()
#'#641025', '#104e64'

gradient_colors <- c('#86ac6a','#ffba00','#f54a00')

## Chart : Distribution of Education
education_colors_map <- c(
  "primary"   = "#6A5ACD",
  "secondary" = "#9370DB",
  "tertiary"  = "#4682B4",
  "unknown"   = "#D3D3D3"
)

data$job2 = data$job

data$job2[data$job2 == "blue-collar"] <- "manual-workers"
data$job2[data$job2 == "services"] <- "manual-workers"
data$job2[data$job2 == "housemaid"] <- "manual-workers"

data$job2[data$job2 == "management"] <- "managers"
data$job2[data$job2 == "admin."] <- "managers"
data$job2[data$job2 == "technician"] <- "managers"

data$job2[data$job2 == "self-employed"] <- "self-employed"
data$job2[data$job2 == "entrepreneur"] <- "self-employed"

data$job2[data$job2 == "unemployed"] <- "inactive"
data$job2[data$job2 == "retired"] <- "inactive"
data$job2[data$job2 == "student"] <- "inactive"

job_colors_map <- c(
  "manual-workers" = "#1f77b4",
  "managers" = "#ff7f0e",
  "self-employed" = "#2ca02c",
  "inactive" = "#9467bd",
  "unknown" = "#c7c7c7"
)
data %>% count(job2, sort = FALSE)

fig <- plot_ly(data %>% count(job2, sort = FALSE), 
               labels = ~job2, 
               values = ~n, 
               type = 'pie',
               textposition = 'inside',
               textinfo = 'label+percent',
               insidetextfont = list(color = '#FFFFFF'),
               hoverinfo = 'text',
               text = ~paste(n,job2),
               marker = list(colors = job_colors_map,
                             line = list(color = '#FFFFFF', width = 1)),
               showlegend = FALSE)

fig <- fig %>% layout(title = 'Distribution of education',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig


## Chart : Education Level Impact
Ntab = table(data$education, data$y)
Ptab = round(prop.table(Ntab) * 100,2)
tab = aggregate(x= data$balance,
          by = list(data$education),
          FUN = mean)

educ_level_impact <- cbind(Ptab, round(tab[, 2],0))
df = as.data.frame(educ_level_impact)
df = rownames_to_column(df, var = "education")
df

no_color <- "#f54a00"
yes_color <- "#86ac6a"

fig <- plot_ly(df, x = ~education, y = ~V3, type = "bar", name = "",
               hovertemplate = paste('Education : %{x}', '<br>Average Balance: %{y}€'),
               marker = list(color = education_colors_map[df$education]),
               showlegend = FALSE) %>%
  add_lines(y = ~no, name = "", yaxis = "y2",
            line = list(color = no_color, width = 2),
            hovertemplate = paste('Failed rate : %{y}%'),
            mode = "lines+markers",
            marker = list(color = no_color, size = 8)) %>%
  add_lines(y = ~yes, name = "", yaxis = "y2",
            hovertemplate = paste('Success Rate : %{y}%'),
            line = list(color = yes_color, width = 2),
            mode = "lines+markers",
            marker = list(color = yes_color, size = 8)) %>%
  layout(
    margin = list(r = 40),
    title = list(text=paste0('Education Level Impact',
                 '<br>',
                 '<sup>',
                 'Success rates and average balance by education level',
                 '</sup>'), x = 0.05, xanchor = 'left'),
    yaxis = list(title = "AVG Balance"),
    yaxis2 = list(
      title = "No / Yes (%)",
      overlaying = "y",
      side = "right",
      tickformat = ".1f%%",
      range = c(0,100)
    ),
    barmode = "group"
  )

fig




## KPI : Success Rate
Ntab = table(data$y)
Ntab
Ptab = round(prop.table(Ntab) * 100,2)
df = as.data.frame(Ptab)
success_rate = df[df$Var1 == 'yes',2]
success_rate

## KPI : AVG Balance
round(mean(data$balance),0)

## KPI : Total Clients
nrow(data)

## KPI : Average calls made per clients
round(mean(data$campaign))

## KPI : Average duration of the calls in minutes
round(mean(data$duration)/60)

## KPI : Success Rate of Previous Campaign
Ntab = table(data$poutcome)
Ntab
Ptab = round(prop.table(Ntab) * 100,2)
df = as.data.frame(Ptab)
df
success_rate = df[df$Var1 == 'success',2]
success_rate

max(data$age)

## Chart : Success per age
data_age = data %>% 
  mutate(
    # Create categories
    age_group = dplyr::case_when(
      age <= 25            ~ "18-25",
      age > 25 & age <= 35 ~ "26-35",
      age > 35 & age <= 45 ~ "36-45",
      age > 45 & age <= 55 ~ "46-55",
      age > 55 & age <= 65 ~ "56-65",
      age > 65             ~ "65+"
    ),
    # Convert to factor
    age_group = factor(
      age_group,
      level = c("18-25", "26-35", "36-45", "46-55", "56-65", "65+")
    )
  )

Ntab = table(data_age$age_group, data$y)
Ntab
df = as.data.frame(Ntab)
df = rownames_to_column(df, var = "age_group")
df
df[df$Var2 == 'no',4]
fig <- plot_ly(df, x = ~df[df$Var2 == 'no',2], y = ~df[df$Var2 == 'no',4], type = 'bar', name = 'Not Subscribed',
               marker = list(color = '#FFA500'))
fig <- fig %>% add_trace(y = ~df[df$Var2 == 'yes',4], name = 'Subscribed',
                         marker = list(color = '#86ac6a'))
fig <- fig %>% layout(yaxis = list(title = ''), barmode = 'stack',
                      xaxis = list(title = 'Age'),
                      title = list(text=paste0('Education Level Impact',
                                               '<br>',
                                               '<sup>',
                                               'Success rates across different age demographics',
                                               '</sup>'), x = 0.05, xanchor = 'left')
                      )
fig


