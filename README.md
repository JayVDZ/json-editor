# JSON Editor

A fully offline JSON editor with visualization capabilities, inspired by JSONCrack.com/editor.

## Features

- ✅ Edit JSON with syntax highlighting
- ✅ Collapsible JSON nodes in the editor
- ✅ Real-time JSON validation
- ✅ Visual graph/tree representation of JSON data
- ✅ Import JSON files
- ✅ Export JSON files
- ✅ JSON Schema validation
- ✅ Draggable graph nodes
- ✅ Zoom controls for visualization
- ✅ Dark theme optimized for readability

## Quick Start

### For Offline/Airgapped Environments (Recommended)

Simply open **`index-offline.html`** in Microsoft Edge or any modern browser. No internet connection required.

### For Environments with Microsoft CDN Access

Open **`index.html`** for a better editor experience using Monaco Editor (requires access to `cdnjs.cloudflare.com`).

## Usage Instructions

1. **Editing JSON**: Type or paste JSON in the left panel
2. **Format JSON**: Click "Format" button to auto-indent
3. **Import File**: Click "Import" and select a `.json` file
4. **Export File**: Click "Export" to download current JSON
5. **Schema Validation**: Click "Schema Validation" button, paste a JSON Schema, and see validation results
6. **Visualization**: The right panel shows a graph view of your JSON structure
   - Drag nodes to rearrange them
   - Use zoom controls (+, -, ⊙) to adjust view
   - Click "Refresh" to reset layout

## Example Files

- `test-data.json` - Sample complex JSON for testing
- `example-schema.json` - Sample JSON Schema for validation testing

## Requirements

- Modern web browser with ES6 support (Edge, Chrome, Firefox)
- No internet connection needed (for `index-offline.html`)
- No installation or server required
- Can be emailed and run directly from desktop

## Architecture

Both versions are completely self-contained single HTML files with all CSS and JavaScript embedded inline. The offline version (`index-offline.html`) has zero external dependencies and works in completely airgapped environments.

## Browser Compatibility

Tested on Microsoft Edge on Windows 11. Should work on any modern browser supporting ES6, FileReader API, Blob API, and SVG.
