#!/usr/bin/env node
/**
 * Block Force Git Hook - Node.js Version (Windows Compatible)
 * Prevents dangerous git operations like force push
 */

let input = '';

process.stdin.setEncoding('utf8');
process.stdin.on('data', (chunk) => { input += chunk; });
process.stdin.on('end', () => {
    try {
        const data = JSON.parse(input);
        const toolName = data.tool_name || '';
        const command = data.tool_input?.command || '';

        // Block git commands with force flags
        const forcePattern = /^git\s.*(--force|--force-with-lease|\s-f(\s|$))/;
        if (toolName === 'Bash' && forcePattern.test(command)) {
            console.error('ERROR: Force push blocked by hook - use ! if needed');
            process.exit(2);
        }
    } catch (e) {
        // JSON parsing failed, pass through
    }
    process.exit(0);
});
