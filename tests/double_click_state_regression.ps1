$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$tabBookmark = Get-Content -LiteralPath (Join-Path $repoRoot 'src\tabbookmark.cc') -Raw
$utils = Get-Content -LiteralPath (Join-Path $repoRoot 'src\utils.cc') -Raw

foreach ($message in @('WM_NCLBUTTONDOWN', 'WM_NCMBUTTONDOWN', 'WM_NCRBUTTONDOWN', 'WM_NCLBUTTONUP')) {
    if ($tabBookmark -notmatch [regex]::Escape($message)) {
        throw "Missing non-client mouse handling: $message"
    }
}

if ($tabBookmark -notmatch 'last_lbutton_down_on_tab') {
    throw 'Missing tab-body gate for double-click tab closing.'
}

if ($utils -notmatch 'GetAncestor\(hwnd, GA_ROOT\)' -or $utils -notmatch 'PostMessageW\(hwnd, WM_SYSCOMMAND') {
    throw 'Commands must be posted to the top-level browser window.'
}
