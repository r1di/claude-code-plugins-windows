# Block Force Git Hook - Windows PowerShell Version
# Prevents dangerous git operations like force push

param()

$input_json = $input | Out-String

try {
    $data = $input_json | ConvertFrom-Json -ErrorAction SilentlyContinue

    $tool_name = $data.tool_name
    $command = $data.tool_input.command

    # Block git commands with force flags
    if ($tool_name -eq "Bash" -and $command -match "^git\s.*(--force|--force-with-lease|\s-f(\s|$))") {
        Write-Error "ERROR: Force push blocked by hook - use ! if needed"
        exit 2
    }
}
catch {
    # If JSON parsing fails, just pass through
}

exit 0
