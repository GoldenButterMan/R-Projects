# install needed libraries if missing
if (!require(tidytext) || !require(magrittr) || !require(dplyr) || !require(ggplot2)) {
    install.packages("tidytext")
    install.packages("magrittr")
    install.packages("dplyr")
    install.packages("ggplot2")
}
library("tidytext")
library("magrittr")
library("dplyr")
library("ggplot2")

# user input for file name
user_prompt <- readline(prompt = "Enter file name: ")
if(!file.exists(user_prompt)){
    stop("This file does not exist")
}
file <- readLines(user_prompt)

# make dataframe and convert to a list of words
text <- data.frame(line = seq_along(file), text = file)
word_list <- text %>%
    unnest_tokens(word, text)

#Remove filler words like 'the' and 'I'
data("stop_words")
word_list <- word_list %>%
    anti_join(stop_words, by = "word")

word_frequency <- word_list %>%
    count(word, sort = TRUE)

print(word_frequency)

# graph top 10 frequent words as bar graph
top_10 <- word_frequency %>%
    slice_max(order_by = n, n = 10, with_ties = FALSE)

print(
    ggplot(top_10, aes(x = reorder(word, n), y = n)) +
        geom_col(fill = "green") +
        coord_flip() +
        labs(title = "Top 10 frequent Words", x = "Word", y = "Frequency")
)
