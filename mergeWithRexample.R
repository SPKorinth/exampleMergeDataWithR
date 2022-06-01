###############################################################################
############# Beispiel R-Skript: Merge einzelner Ergebnisdateien ##############
###############################################################################

# Im Unterordner "resultFolder" befinden sich Dummy-Dateien, mit zufällig 
# generierten Ergebnissen. Dies 20 Dateien sollen mit folgendem Loop zu einem
# R data frame vereint werden


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



