#!/usr/bin/env node
/**
 * File Write Cleanup Hook - Node.js Version (Windows Compatible)
 * Removes trailing whitespace and ensures files end with newline
 */

const fs = require('fs');
const path = require('path');

let input = '';

process.stdin.setEncoding('utf8');
process.stdin.on('data', (chunk) => { input += chunk; });
process.stdin.on('end', () => {
    try {
        const data = JSON.parse(input);
        const filePath = data.tool_input?.file_path || data.tool_response?.filePath;

        if (filePath && fs.existsSync(filePath) && fs.statSync(filePath).isFile()) {
            let content = fs.readFileSync(filePath, 'utf8');

            // Remove trailing whitespace from each line
            const lines = content.split(/\r?\n/).map(line => line.trimEnd());
            let cleaned = lines.join('\n');

            // Ensure file ends with newline
            if (!cleaned.endsWith('\n')) {
                cleaned += '\n';
            }

            fs.writeFileSync(filePath, cleaned, 'utf8');
            console.log('{"success": true, "message": "File cleaned: removed trailing whitespace and ensured newline at end"}');
        } else {
            console.log('{"success": true, "message": "File does not exist or is not a regular file, skipping cleanup"}');
        }
    } catch (e) {
        console.log('{"success": true, "message": "Hook executed (Windows mode)"}');
    }
    process.exit(0);
});
