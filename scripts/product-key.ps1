param (
    [string]$file,
    [string]$key
)

if (! (Test-Path .\tmp)) {
    New-Item -Path .\tmp -ItemType Directory
}

if (! $key) {
    Write-Warning "No key provided"
    Copy-Item $file .\tmp\Autounattend.xml | Out-Null
}
else {
    (Get-Content -Path $file -Raw) `
        -replace '<!-- <Key>xxxxx-xxxxx-xxxxx-xxxxx-xxxxx</Key> -->', "<Key>$key</Key>" `
        -replace '<Key>\w{5}-\w{5}-\w{5}-\w{5}-\w{5}</Key>', "<Key>$key</Key>" |
        Out-File .\tmp\Autounattend.xml -Encoding utf8
}