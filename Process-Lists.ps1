    # Subfunction: Format bullet and numbered list items onto individual lines
    function Process-Lists {
        param ([string]$Text)

        # Place line breaks before each bullet or number, if mashed together
        $Text = $Text -replace '(?<!^)\s*-\s*', "`r`n- "
        $Text = $Text -replace '(?<!^)\s*(\d+)\.\s*', "`r`n$1. "
        return $Text
    }
