library(tidyverse)
library(tokenizers)
texto <- paste("También entiendo que como es temporada de elecciones, las expectativas para lo que lograremos este año son bajas. Aún así, señor Presidente de la Cámara de Representantes, aprecio el enfoque constructivo que usted y los otros líderes adoptaron a finales del año pasado para aprobar un presupuesto, y hacer permanentes los recortes de impuestos para las familias trabajadoras. Así que espero que este año podamos trabajar juntos en prioridades bipartistas.")
palabras <- tokenize_words(texto)
palabras
length(palabras)
length(palabras[[1]])
tabla <- table(palabras[[1]])
tabla <- data_frame(palabra = names(tabla), recuento = as.numeric(tabla))
tabla
arrange(tabla, desc(recuento))
oraciones <- tokenize_sentences(texto)
oraciones
oraciones_palabras <- tokenize_words(oraciones[[1]])
oraciones_palabras
length(oraciones_palabras)

length(oraciones_palabras[[1]])

length(oraciones_palabras[[2]])
length(oraciones_palabras[[3]])
sapply(oraciones_palabras, length)

base_url <- "https://programminghistorian.org/assets/basic-text-processing-in-r"
url <- sprintf("%s/sotu_text/236.txt", base_url)
texto <- paste(readLines(url), collapse = "\n")
palabras <- tokenize_words(texto)
length(palabras[[1]])
tabla <- table(palabras[[1]])
tabla <- data_frame(word = names(tabla), count = as.numeric(tabla))
tabla <- arrange(tabla, desc(count))
tabla
palabras_frecuentes <- read_csv(sprintf("%s/%s", base_url, "word_frequency.csv"))
palabras_frecuentes
tabla <- inner_join(tabla, palabras_frecuentes)
tabla
filter(tabla, frequency < 0.1)
print(filter(tabla, frequency < 0.002), n = 15)