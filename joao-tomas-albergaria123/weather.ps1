
$url = "https://api.openweathermap.org/data/2.5/weather"
$apiKey = "API_KEY"


$cities = "London", "Paris", "New York", "Tokyo","Porto"


$weatherInfo = @()


foreach ($city in $cities) {

    $requestUrl = "$url"+"?q=$city&appid=$apiKey"

    $response = Invoke-RestMethod -Uri $requestUrl -Method Get

   
    $temperature = $response.main.temp-273
    $humidity = $response.main.humidity
    $description = $response.weather[0].description

   
    $weatherObj = [PSCustomObject]@{
        City = $city
        Temperature = $temperature
        Humidity = $humidity 
        Description = $description
    }

  
    $weatherInfo += $weatherObj
}

$weatherInfo | Export-Csv -Path "weather.csv" -NoTypeInformation 

$end="File created!"
$end
