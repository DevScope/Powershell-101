# Script para obtermos os valores das criptos mais altas através do site coinmarketcap


Import-Module -Name Microsoft.PowerShell.Utility
Import-Module -Name Microsoft.PowerShell.WebService


$url = "https://coinmarketcap.com/"

# Usar o Invoke-WebRequest para enviar uma solicitação HTTP para o URL e obter o conteúdo HTML
$response = Invoke-WebRequest -Uri $url


$table = $response.ParsedHtml.getElementById("cryptocurrency") | Select-Object -First 1
$rows = $table.getElementsByTagName("tr")


$data = @()



foreach ($row in $rows) {
    $cells = $row.getElementsByTagName("td")
    if ($cells.Count -gt 0) {
        $rank = $cells[0].innerText
        $name = $cells[1].getElementsByTagName("a").innerText
        $price = $cells[3].innerText
        $data += [PSCustomObject]@{
            "Rank" = $rank
            "Nome" = $name
            "Preço" = $price
        }
    }
}


#  Ordenar as criptos por preço
$data = $data | Sort-Object -Property Preço -Descending


$data
