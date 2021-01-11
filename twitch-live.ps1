$authToken = ""
$total = 50
$userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36"

$uri = "https://gql.twitch.tv/gql"
$headers = @{
    "Accept" = "*/*"
    "Accept-Encoding" = "gzip, deflate, br"
    "Accept-Language" = "en-US"
    "Authorization" = $authToken
    "Client-Id" = "kimne78kx3ncx6brgo4mv6wki5h1ko"
    "Connection" = "keep-alive"
    "Content-Type" = "text/plain;charset=UTF-8"
    "DNT" = 1
    "Host" = "gql.twitch.tv"
    "Origin" = "https://www.twitch.tv"
    "User-Agent" = $userAgent
}

$gqlBody = "{`"query`":`"query{currentUser{followedLiveUsers(first:$($total)){edges{node{login stream{viewersCount game{displayName} title createdAt}}}}}}`"}"

try {
    $gqlResponse = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $gqlBody

    if(!$gqlResponse.errors){
        if ($gqlResponse.data.currentUser.followedLiveUsers.edges.Count -lt 1) {
            Write-Host "All offline!"
        } else {
            foreach ($nodeValue in $gqlResponse.data.currentUser.followedLiveUsers.edges) {
                Write-Host "[*] $($nodeValue.node.login)" -NoNewline
                Write-Host " ($($nodeValue.node.stream.game.displayName))" -NoNewline -ForeGroundColor Gray
                Write-Host " | " -NoNewline
                Write-Host "$("{0:N0}" -f $nodeValue.node.stream.viewersCount)" -NoNewline -ForegroundColor Red
                Write-Host " $(($nodeValue.node.stream.viewersCount -ne 1) ? 'viewers' : 'viewer') " -NoNewline
                Write-Host "| $((New-TimeSpan -End "$((Get-Date).ToUniversalTime())" -Start $nodeValue.node.stream.createdAt).ToString("hh\:mm\:ss"))"
            }
        }
    } else {
        Write-Host "Error! $($gqlResponse.errors.message)"
    }
} catch {
    Write-Host "Error: $($_.Exception.Response.ReasonPhrase)"
    Write-Host "StatusCode: $($_.Exception.Response.StatusCode.value__)"
    # Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
}
