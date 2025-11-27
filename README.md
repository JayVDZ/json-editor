# JSON Editor

A fully offline JSON editor with visualisation capabilities..

## Features

- ✅ Edit JSON with syntax highlighting
- ✅ Collapsible JSON nodes in the editor
- ✅ Real-time JSON validation
- ✅ Multiple visualisation types:
  - **Graph View**: Traditional tree layout with draggable nodes
  - **Force-Directed**: Interactive physics-based D3.js visualisation
- ✅ Import JSON files
- ✅ Export JSON files
- ✅ JSON Schema validation
- ✅ Draggable graph nodes
- ✅ Zoom controls for visualisation
- ✅ Dark theme optimised for readability

## Quick Start

### For Offline/Airgapped Environments

Simply open **`index.html`** in Microsoft Edge or any modern browser. No internet connection required.

## Usage Instructions

1. **Editing JSON**: Type or paste JSON in the left panel
2. **Format JSON**: Click "Format" button to auto-indent
3. **Import File**: Click "Import" and select a `.json` file
4. **Export File**: Click "Export" to download current JSON
5. **Schema Validation**: Click "Schema Validation" button, paste a JSON Schema, and see validation results
6. **Visualisation**: The right panel shows a graph view of your JSON structure
   - **Switch View**: Use the dropdown to select between "Graph View" (tree layout) or "Force-Directed" (physics simulation)
   - **Graph View**: Drag nodes to rearrange them manually
   - **Force-Directed**: Interactive physics-based layout that automatically organises nodes
   - Use zoom controls (+, -, ⊙) to adjust view
   - Click "Refresh" to reset layout
   - Your visualisation preference is automatically saved

## Example Files

- `test-data.json` - Sample complex JSON for testing
- `example-schema.json` - Sample JSON Schema for validation testing

## Requirements

- Modern web browser with ES6 support (Edge, Chrome, Firefox)
- No internet connection needed
- No installation or server required
- Can be emailed and run directly from desktop

## Architecture

The application is a completely self-contained single HTML file (`index.html`) with all CSS and JavaScript embedded inline. It includes the D3.js library (v7.9.0) embedded for advanced visualisations, and works in completely airgapped environments with zero external dependencies.

## Browser Compatibility

Tested on Microsoft Edge on Windows 11. Should work on any modern browser supporting ES6, FileReader API, Blob API, and SVG.
