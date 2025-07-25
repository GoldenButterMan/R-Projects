#install needed libraries if missing
if(!require(tidytext) | !require(magrittr) | !require(dplyr) | !require(ggplot2)){
    install.packages("tidytext");
    install.packages("magrittr");
    install.packages("dplyr");
    install.packages("ggplot2");
}
library("tidytext");
library("magrittr");
library("dplyr");
library("ggplot2");

#user input for file name
userPrompt <- readline(prompt = "Enter file name: ");
file <- readLines(userPrompt);

#make dataframe and convert to a list of words
text <- data.frame(line = 1:length(file), text = file);
wordList <- text %>%
    unnest_tokens(word, text);

wordFrequency <- wordList %>%
    count(word, sort = TRUE);

print(wordFrequency);