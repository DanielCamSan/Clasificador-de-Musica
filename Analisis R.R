#::::::::::::::::::::GRAFICO DE NUBE DE PALABRAS::::::::::::::::

#representar graficamente un texto, para dar una idea de lo que contiene
#se dibuja las palabaras mas frecuentes, + palabras-> + grande el texto

#instalamos todos los paquetes que necesitamos
install.packages("tm")
install.packages("NLP")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")

#cargamos las librerias correspondientes
library(tm)
library(NLP)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)

texto <- readLines("C://Users//Dani Camacho//Desktop//9 Semestre//Metodologia//Clasificador//abstracts.txt")

texto = iconv(texto, to="ASCII//TRANSLIT")
texto = Corpus(VectorSource(texto)) 

########### LIMPIAMOS NUESTRO TEXTO CON EL COMANDO tm_map

#ponemos todos los datos a minuscula (A!=a)
discurso=tm_map(texto, tolower)
#quitamos los espacios en blanco
discurso =tm_map(discurso, stripWhitespace)
#quitamos la puntuacion
discurso = tm_map(discurso, removePunctuation)
#quitamos los numeros
discurso = tm_map(discurso, removeNumbers)

#mostramos palabras vacias y genericas
stopwords("english")
#quitamos palabras genericas
discurso=tm_map(discurso, removeWords,stopwords("english"))

#tambien podemos tener nuestra propia lista de palabras a quitar

############### DATA FRAME DE PALABRAS CON SU FRECUENCIA

#Creamos matriz de letras
letras= TermDocumentMatrix(discurso)
findFreqTerms(letras, lowfreq=5)
matrix=as.matrix(letras)

#lo ordenamos y sumamos las letras de nuestra matriz
vector <- sort(rowSums(matrix),decreasing=TRUE) 
#creamos la data con las palabras y su frecuencia
dataletras <- data.frame(word= names(vector),frequencia=vector) 
# lo nombra y le da formato de data.frame

################ GRAFICAMOS FRECUENCIA DE LAS PALABRAS

barplot(dataletras[1:10,]$freq, las = 2, names.arg = dataletras[1:10,]$word,
        col ="blue", main ="PALABRAS MÁS FRECUENTES", ylab = "Frecuencia de palabras")


############ GRAFICAMOS LA NUBE DE PALABRAS
wordcloud(words = dataletras$word, freq = dataletras$freq, min.freq = 2,
          max.words=70)
#en el centro la palabra mas importante, 
wordcloud(words = dataletras$word, freq = dataletras$freq, min.freq = 2,
          max.words=70, random.order=FALSE, rot.per=0.2, 
          colors=brewer.pal(8, "Dark2"))

