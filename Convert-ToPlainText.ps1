function Convert-ToPlainText {
    param (
        [string]$InputText
    )

    # Subfunction: Remove non-ASCII characters (including emojis)
    function Remove-Emojis {
        param ([string]$Text)
        return -join ($Text.ToCharArray() | Where-Object {
            $code = [int][char]$_
            $code -ge 32 -and $code -le 126
        })
    }

    # Subfunction: Format bullet and numbered list items onto individual lines
    function Process-Lists {
        param ([string]$Text)

        # Place line breaks before each bullet or number, if mashed together
        $Text = $Text -replace '(?<!^)\s*-\s*', "`r`n- "
        $Text = $Text -replace '(?<!^)\s*(\d+)\.\s*', "`r`n$1. "
        return $Text
    }

    # Step 1: Strip emojis and Unicode artifacts
    $cleanText = Remove-Emojis $InputText

    # Step 2: Remove RTF control codes if present
    $cleanText = $cleanText -replace '\\u\d{1,5}\??', '' -replace '\\uc\d+', ''

    # Step 3: Strip Markdown formatting
    $cleanText = $cleanText -replace '\*\*(.*?)\*\*', '$1'
    $cleanText = $cleanText -replace '\*(.*?)\*', '$1'
    $cleanText = $cleanText -replace '`([^`]*)`', '$1'
    $cleanText = $cleanText -replace '---+', "`r`n"

    # Step 4: Normalize headers
    $cleanText = $cleanText -replace '###\s*', "`r`n"

    # Step 5: Process bullet and numbered lists
    $cleanText = Process-Lists $cleanText

    # Step 6: Clean up line breaks and spacing
    $lines = $cleanText -split "`r?`n" | Where-Object { $_.Trim() -ne '' }
    return ($lines | ForEach-Object { $_.Trim() }) -join "`r`n"
}
