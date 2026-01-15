# File Write Cleanup Hook - Windows PowerShell Version
# Removes trailing whitespace and ensures files end with newline

param()

$input_json = $input | Out-String

try {
    $data = $input_json | ConvertFrom-Json -ErrorAction SilentlyContinue

    $file_path = $data.tool_input.file_path
    if (-not $file_path) {
        $file_path = $data.tool_response.filePath
    }

    if ($file_path -and (Test-Path $file_path -PathType Leaf)) {
        # Read file content
        $content = Get-Content $file_path -Raw -ErrorAction SilentlyContinue

        if ($content) {
            # Remove trailing whitespace from each line
            $lines = $content -split "`r?`n" | ForEach-Object { $_.TrimEnd() }
            $cleaned = $lines -join "`n"

            # Ensure file ends with newline
            if (-not $cleaned.EndsWith("`n")) {
                $cleaned += "`n"
            }

            # Write back
            [System.IO.File]::WriteAllText($file_path, $cleaned)
        }

        Write-Output '{"success": true, "message": "File cleaned: removed trailing whitespace and ensured newline at end"}'
    }
    else {
        Write-Output '{"success": true, "message": "File does not exist or is not a regular file, skipping cleanup"}'
    }
}
catch {
    Write-Output '{"success": true, "message": "Hook executed (Windows mode)"}'
}

exit 0
