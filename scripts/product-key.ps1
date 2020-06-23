param (
    [string]$path,
    [string]$key
)

if (! $key) {
    Write-Warning "No key provided"
    exit
}

if (! (Test-Path .\tmp)) {
    New-Item -Path .\tmp -ItemType Directory
}

(Get-Content -Path $path -Raw) `
    -replace '<!-- <Key>xxxxx-xxxxx-xxxxx-xxxxx-xxxxx</Key> -->', "<Key>$key</Key>" `
    -replace '<Key>\w{5}-\w{5}-\w{5}-\w{5}-\w{5}</Key>', "<Key>$key</Key>" |
    Out-File .\tmp\Autounattend.xml -Encoding utf8
