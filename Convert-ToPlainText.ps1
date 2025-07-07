<#
.SYNOPSIS
    Cleans and converts AI-generated or markdown-formatted text into human-friendly plain text.
    Strips emojis, non-ASCII characters, and normalizes bullet and numbered list formatting.

.DESCRIPTION
    This script was developed collaboratively by [Your Name] and Microsoft Copilot,
    an AI companion designed to assist with automation, formatting, and language tasks.

    It was created during an in-depth development session focused on recipe formatting,
    clipboard cleanup, and layout restoration for human-readable use.

.AUTHOR
    GrandpaCode
    Microsoft Copilot (https://copilot.microsoft.com)

.LICENSE
    Open Source – feel free to modify, share, and improve!
    Attribution appreciated when reused.

.VERSION
    1.0.0

.NOTES
    Publish Date: 7/7/2025
    Original Concept by: GrandpaCode
    AI Assistance & Formatting Logic: Microsoft Copilot
#>


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
