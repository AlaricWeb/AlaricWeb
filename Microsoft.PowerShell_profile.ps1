# 1. 设置为 Vi 模式
Set-PSReadLineOption -EditMode Vi

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewline "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewline "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

Set-PSReadLineKeyHandler -Chord 'j' -ScriptBlock {
  if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()) {
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    if ($key.Character -eq 'j') {
      [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    }
    else {
      [Microsoft.Powershell.PSConsoleReadLine]::Insert('j')
      [Microsoft.Powershell.PSConsoleReadLine]::Insert($key.Character)
    }
  }
}
