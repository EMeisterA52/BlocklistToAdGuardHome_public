# Quelle:
# https://github.com/RPiList/specials/blob/master/Blocklisten.md

# PowerShell-Execution-Policy EIN / AUS
# Öffnen Sie die PowerShell als Administrator.
# Set-ExecutionPolicy RemoteSigned -Scope Process
# C:\Users\PC\Desktop\BlocklistenToAdGuardHome.ps1
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Default
#
# nano /opt/AdGuardHome/AdGuardHome.yaml


# Definiere die Dateipfade
$sourceFile = "Blocklisten.md.txt"
$destinationFile = "AdGuardHome.yaml.txt"

# Initialisiere die Start-ID
$id = 1711874235

# Öffne die Quelldatei zum Lesen
$lines = Get-Content -Path $sourceFile

# Öffne die Zieldatei zum Schreiben
$output = foreach ($line in $lines) {
    # Extrahiere den Namen aus der URL
    $name = ($line -split '/')[@($line -split '/').Length - 1]

    # Erhöhe die ID um 1
    $id++

    # Erzeuge den YAML-Eintrag
    @"
  - enabled: true
    url: $line
    name: $name
    id: $id
"@
}

# Schreibe den Inhalt in die Zieldatei
$output | Out-File -FilePath $destinationFile

Write-Host "Das Skript wurde erfolgreich ausgeführt."