#install needed libraries if missing
if(!require(tidytext) || !require(magrittr) || !require(dplyr) || !require(ggplot2)){
    install.packages("tidytext")
    install.packages("magrittr")
    install.packages("dplyr")
    install.packages("ggplot2")
}
library("tidytext")
library("magrittr")
library("dplyr")
library("ggplot2")

#user input for file name
user_prompt <- readline(prompt = "Enter file name: ")
file <- readLines(user_prompt)

#make dataframe and convert to a list of words
text <- data.frame(line = seq_along(file), text = file)
word_list <- text %>%
  unnest_tokens(word, text)

word_frequency <- word_list %>%
  count(word, sort = TRUE)

print(word_frequency)

#graph word frequency as bar graph

ggplot(word_frequency, aes(x = reorder(word, n), y = n)) +
  geom_col(fill = "green") +
  coord_flip() +
  labs(title = "Top 10 frequent Words", x = "Word", y = "Frequency")
