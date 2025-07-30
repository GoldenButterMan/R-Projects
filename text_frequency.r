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
userPrompt <- readline(prompt = "Enter file name: ")
file <- readLines(userPrompt)

#make dataframe and convert to a list of words
text <- data.frame(line = 1:length(file), text = file)
wordList <- text %>%
    unnest_tokens(word, text)

wordFrequency <- wordList %>%
    count(word, sort = TRUE)

print(wordFrequency)

#graph word frequency as bar graph
windows()
ggplot(wordFrequency, aes(x = reorder(word, n), y = n)) +
  geom_col(fill = "green") +
  coord_flip() +
  labs(title = "Top 10 frequent Words", x = "Word", y = "Frequency")
