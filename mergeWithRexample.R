###############################################################################
############# Beispiel R-Skript: Merge einzelner Ergebnisdateien ##############
###############################################################################

# Im Unterordner "resultFolder" befinden sich Dummy-Dateien, mit zufällig 
# generierten Ergebnissen. Dies 20 Dateien sollen mit folgendem Loop zu einem
# R data frame vereint werden.

# Erstellt eine Liste der relevanten Dateien. Wenn alle Dateien im Unterordner
# "resultFolder" einbezogen werden sollen oder dort nur Dateien mit der Endung
# ".csv" liegen, kann auf das Argument "pattern" verzichtet werden.
file.list <- list.files(path = "resultFolder/", pattern = "*.csv")

# Im folgenden Loop werden nacheinander alle Dateien eingelesen und über die
# Funktion rbin() "übereinander gestapelt". Das Ergebnis ist ein data frame im
# sogenannten long format namens "merged.data" (arbiträrer Name).
for (file.counter in 1:length(file.list)) {
  temp.df <-
    read.csv(paste("resultFolder/", file.list[file.counter], sep = ""))
  
  # Der data frame für die erste Datei wird in merged.data umbenannt, da es noch
  # keinen data frame gibt, der mit dieser Datei verbunden werden kann.
  if (file.counter == 1) {
    merged.data <- temp.df
  } else {
    merged.data <- rbind(merged.data, temp.df)
  }
}

# Löschen aller temporären Variablen (Ordnung muss sein.)
rm(temp.df, file.counter, file.list)

# Speichern des data frames als Datei
saveRDS(merged.data, file = "alleMeineDaten.Rds")


###############################################################################
############# Beispiel R-Skript: long zu wide Format ##########################
###############################################################################

# Obwohl die bevorzugte Datenstruktur in R das long-Format ist, könnte es nötig
# werden, eine Umstrukturierung von Daten in das wide-Format vorzunehmen (z.B.,
# wenn Kollegen lieber mit SPSS arbeiten). 
# Hierfür gibt es unter R zahlreiche Optionen, von denen das reshape2-Paket für
# lange Zeit als Standard galt. Da dieses Paket nicht mehr weiterentwickelt 
# wird, empfehlen wir das Paket tidyr (vom selben Entwickler).

library(tidyr)

# Wir laden die Daten, welche im Skript "mergeWithRexample.R" erstellt wurden. 
# Der data frame besteht aus 200 Zeilen und 4 Spalten
long.format <- readRDS("alleMeineDaten.Rds")

# Wollen wir jetzt zum Beispiel die Daten so umstrukturieren, dass jede Zeile 
# eine Versuchsperson repräsentiert und jede Spalte die Reaktionszeit bzw. die
# Reaktionsgenauigkeit für die einzelnen Trials, können wir die Funktion
# "pivot_wider()" nutzen.

wide.format <- pivot_wider(long.format, 
                           names_from = trialIndex, 
                           values_from = c(trialRT, trialCorrect))

# Der resultierende data frame besteht aus 20 Zeilen (= 20 Versuchspersonen) 
# und 21 Spalten (= 1 Spalte für die Versuchspersonennamen, 10 Spalten für die
# Reaktionszeiten, 10 Spalten für Reaktionsgenauigkeit).
# Weitere Informationen unter: https://tidyr.tidyverse.org




