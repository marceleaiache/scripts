#######################################
###                                 ###
###     Desenvolvido por Panda      ### 
###                                 ###
#######################################

$file = "testlink.properties"
$currentDate = Get-Date -Format "yy_MM_dd"

# Obtém o diretório atual onde o executável está localizado
$scriptDir = (Get-Location).Path

# Constrói o caminho completo para o arquivo
$filePath = Join-Path -Path $scriptDir -ChildPath "bin\properties\INOVA\$file"

# Mensagens de depuração
Write-Host "Diretório do script: $scriptDir"
Write-Host "Caminho do arquivo: $filePath"

if (Test-Path $filePath) {
    $line = Get-Content $filePath
    $updatedLine = $line -replace '^prop\.buildname=.*$', "prop.buildname=Release_$currentDate"
    $updatedLine | Set-Content $filePath
    Write-Host "Data atualizada com sucesso."
} else {
    Write-Host "Arquivo não encontrado: $filePath"
}

