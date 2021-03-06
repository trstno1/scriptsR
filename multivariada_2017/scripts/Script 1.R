###############################################################
#ESTATISTICA MULTIVARIADA AULA 2 NO R                         #
#15/08/2017                                                   #
#Marcos V C Vital                                             #
#Estat. multivariada, ppg-dibict, ufal                        #
###############################################################

#Estabelecendo a pasta e lendo os dados:

setwd("D:/R/multivariada 2017")
#Mude o endere�o acima, para o da pasta de trabalho no seu computador

#Ou, se preferir, fa�a: setwd(choose.dir())
#Neste caso, o R vai abrir uma janela, e voc� seleciona a pasta manualmente

#Conferindo os arquivos da pasta:
dir()

spe<-read.csv("DoubsSpe.csv", row.names=1)  #Dados das esp�cies de peixes
env<-read.csv("DoubsEnv.csv", row.names=1)  #Vari�veis ambientais nos locais de coleta
spa<-read.csv("DoubsSpa.csv", row.names=1)  #Coordenadas dos locais de coleta

#O argumento row.names=1 indica que a primeira coluna dos arquivos cont�m os nomes das unidades amostrais

#Conferindo os dados com a fun��o str:
str(spe)
str(env)
str(spa)

#Alternativamente, voc� pode conferir os dados usando summary()
#Mas cuidado: n�o � muito pr�tico quando os dados tem muitas colunas (como � o caso do nosso objeto spe)

#Carregando o pacote necess�rio:
library(vegan)

#Se voc� n�o tem o pacote, pode mandar o R instalar usando o comando install.packages("vegan")

##################################################

#Come�ando a trabalhar com os dados

#Visualizando os pontos no espa�o:
plot(spa$X, spa$Y)

#"Desenhando" o trajeto do rio:
plot(spa$X, spa$Y, type="n")
lines(spa$X, spa$Y, col="blue4")
text(spa$X, spa$Y, row.names(spa), col="red")


#Adicionando riqueza de esp�cies:

riqueza<-specnumber(spe)
plot(spa$X, spa$Y, type="n", ylim=c(20, 120), xlab="Coordenada X (km)", ylab="Coordenada Y (km)", las=1)
lines(spa$X, spa$Y, col="blue4")
points(spa$X, spa$Y, cex=riqueza/3.5, pch=16, col="gray")  #Aqui adicionamos c�rculos cinza, com tamanho proporcional ao n�mero de esp�cies de cada ponto.
points(spa$X, spa$Y, cex=riqueza/3.5, pch=1)  #Agora adicionamos bordas aos c�rculos.
points(spa$X, spa$Y, cex=0.5, pch=16)  #E, finalmente, adicionamos um ponto central em cada ponto.

###########################################

#Explorando correla��es:

#Vamos criar um objeto com as vari�veis f�sico-qu�micas da �gua:
fisqui<-env[ , 5:11]

#Correla��es entre as vari�veis:
cor(fisqui, method="pearson")

#Painel de gr�ficos:
pairs(fisqui)

###
#Painel de gr�ficos com correla��o:

panel.hist <- function(x, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.5) )
    h <- hist(x, plot = FALSE)
    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}


panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y))
    txt <- format(c(r, 0.123456789), digits = digits)[1]
    txt <- paste0(prefix, txt)
    if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = 2)
}


pairs(fisqui, diag.panel=panel.hist, upper.panel = panel.cor)

