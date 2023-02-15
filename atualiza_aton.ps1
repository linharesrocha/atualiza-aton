# Mata todos os processos do Ambar
if (Get-Process -Name "Ambar" -ErrorAction SilentlyContinue) {
    Get-Process "Ambar" | ForEach-Object { $_.Kill() }
    Write-Host "Aton foi fechado forçadamente. Tchau, Aton! 😢"
}

# Mensagem para não abrir o Aton
Write-Host "Não abra o Aton enquanto ele se renova, a menos que você queira ver faíscas voando! 🔥"

# Definir o caminho para a pasta de destino
$destination = "C:\Ambar"

# Definir a URL do repositório GitHub
$repository = "https://github.com/linharesrocha/atualiza-aton/blob/master/atualiza-aton.zip?raw=true"

# Usar o cmdlet Invoke-WebRequest para baixar os arquivos
Invoke-WebRequest $repository -OutFile "$destination\repository.zip"

# Descompactar o arquivo baixado
$shell = new-object -com shell.application

$zip = $shell.NameSpace("$destination\repository.zip")
foreach ($item in $zip.items()) {
    $file = [System.IO.Path]::GetFileName($item.Path)
    if (Test-Path "$destination\$file") {
        Remove-Item "$destination\$file"
    }
    $shell.NameSpace("$destination").CopyHere($item)
}

# Remover o arquivo zip original
Remove-Item "$destination\repository.zip"
Write-Host "Sucesso! Você pode abrir o Aton novamente. 🎉"
