# Definir o caminho para a pasta de destino
$destination = "C:\Ambar"
Write-Host "Buscando C:\Ambar"

# Definir a URL do repositório GitHub
$repository = "https://github.com/linharesrocha/atualiza-aton/blob/master/atualiza-aton.zip?raw=true"
Write-Host "Baixando arquivos Ambar na nuvem"

# Usar o cmdlet Invoke-WebRequest para baixar os arquivos
Invoke-WebRequest $repository -OutFile "$destination\repository.zip"
Write-Host "Baixando os arquivos em um zip"

# Descompactar o arquivo baixado
$shell = new-object -com shell.application
Write-Host "Descompactando o arquivo baixado"

$zip = $shell.NameSpace("$destination\repository.zip")
foreach ($item in $zip.items()) {
    $file = [System.IO.Path]::GetFileName($item.Path)
    if (Test-Path "$destination\$file") {
        Remove-Item "$destination\$file"
        Write-Host "Removendo os arquivos desatualizados da pasta Ambar"
    }
    $shell.NameSpace("$destination").CopyHere($item)
    Write-Host "Copiando os arquivos atualizados para a pasta Ambar"
}

# Remover o arquivo zip original
Remove-Item "$destination\repository.zip"
Write-Host "Removendo o arquivo zip baixado"
Write-Host ""
Write-Host "Sucesso!"
