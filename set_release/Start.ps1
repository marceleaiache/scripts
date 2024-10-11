#######################################
###                                 ###
###     Desenvolvido por Panda      ###
###                                 ###
#######################################


# variaveis setadas
$currentDate = Get-Date -Format "yy_MM_dd"
$scriptDir = (Get-Location).Path
$baseDir = Join-Path -Path $scriptDir -ChildPath "bin\properties\INOVA"
$fileTestLink = Join-Path -Path $baseDir -ChildPath "testlink.properties"
$fileInova = Join-Path -Path $baseDir -ChildPath "inova.properties"
$fileGlobal = Join-Path -Path $scriptDir -ChildPath "bin\resources\global.json"

$systemUsername = Read-Host -Prompt "Usuario"
$systemPassword = Read-Host -Prompt "Senha" -AsSecureString 

# converter a senha para texto simples para gravação no arquivo
$systemPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($systemPassword)
)

Clear-Host
$concessao = Read-Host -Prompt "Concessao" 
Clear-Host
$concessao = $concessao.ToUpper()

# mensagens de depuração
Write-Host "Diretorio do script: $scriptDir"
Write-Host "Caminho do arquivo para mudar o nome da release TesteLink: $fileTestLink"
Write-Host "Caminho do arquivo que seta o usuario e senha: $fileInova"
Write-Host "Caminho do arquivo global que seta a concessao: $fileGlobal"

# funcionalidade que seta a release com a data atual
if (Test-Path $fileTestLink) {
    $line = Get-Content $fileTestLink
    $updatedLine = $line -replace '^prop\.buildname=.*$', "prop.buildname=Release_$currentDate"
    $updatedLine | Set-Content $fileTestLink
    Write-Host "Data atualizada com sucesso."
} else {
    Write-Host "Arquivo nao encontrado: $fileTestLink"
}

# funcionalidade que atualiza o arquivo inova com nome de usuário e senha
if (Test-Path $fileInova) {
    $lineInova = Get-Content $fileInova
    $lineInova = $lineInova -replace '^prop\.system_username=.*$', "prop.system_username=$systemUsername"
    $lineInova = $lineInova -replace '^prop\.system_password=.*$', "prop.system_password=$systemPassword"
    $lineInova | Set-Content $fileInova
    Write-Host "Usuario e senha atualizados com sucesso no arquivo inova."
} else {
    Write-Host "Arquivo inova nao encontrado: $fileInova"
}

# funcionalidade que atualiza o arquivo global com a concessão
if (Test-Path $fileGlobal) {
    $lineGlobal = Get-Content $fileGlobal
    $lineGlobal = $lineGlobal -replace '"concessao":.*$', "`"concessao`": `"$concessao`"" 
    $lineGlobal | Set-Content $fileGlobal
    Write-Host "Concessao atualizada com sucesso no arquivo global."
} else {
    Write-Host "Arquivo global nao encontrado: $fileGlobal"
}

# funcionalidade que executa o arquivo Start_SeleniumServer
$seleniumPath = Join-Path -Path $scriptDir -ChildPath "bin\Selenium\Start_SeleniumServer.bat"
if (Test-Path $seleniumPath) {
    Start-Process $seleniumPath
    Write-Host "Arquivo Start_SeleniumServer executado com sucesso."
} else {
    Write-Host "Arquivo Start_SeleniumServer nao encontrado: $seleniumPath"
}

# funcionalidade que executa o arquivo Executor
$executorPath = Join-Path -Path $scriptDir -ChildPath "bin\Executor.jar"
if (Test-Path $executorPath) {
    Start-Process $executorPath -WorkingDirectory (Join-Path -Path $scriptDir -ChildPath "bin")
    Write-Host "Arquivo Executor executado com sucesso."
} else {
    Write-Host "Arquivo Executor nao encontrado: $executorPath"
}
