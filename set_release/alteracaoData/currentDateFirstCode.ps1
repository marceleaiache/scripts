#######################################
###                                 ###
###     Desenvolvido por Panda      ### 
###                                 ###
#######################################

$file = "testlink.properties"
$currentDate = Get-Date -Format "yy_MM_dd"
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
$filePath = Join-Path -Path $scriptDir -ChildPath "bin\properties\INOVA\$file"



if (Test-Path $filePath) {
    $line = Get-Content $filePath
    $updatedLine = $line -replace '^prop\.buildname=.*$',"prop.buildname=Release_$currentDate"
    $updatedLine | Set-Content $filePath
    Write-Host "Data atualizada com sucesso."
} else {
    Write-Host "Arquivo não encontrado: $filePath"
}

Read-Host -Prompt "Pressione Enter para fechar"
