    # Subfunction: Remove non-ASCII characters (including emojis)
    function Remove-Emojis {
        param ([string]$Text)
        return -join ($Text.ToCharArray() | Where-Object {
            $code = [int][char]$_
            $code -ge 32 -and $code -le 126
        })
    }
