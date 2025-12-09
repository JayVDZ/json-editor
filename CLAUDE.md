# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a fully offline JSON editor web application inspired by JSONCrack.com/editor. The application provides JSON editing with syntax highlighting, real-time validation, graph visualisation, and JSON Schema support. It is designed to run in isolated environments without internet access.

## Language and Spelling

**Important:** All documentation, comments, and user-facing text must use British English (en-GB) spelling conventions.

Examples:
- Use "colour" not "color"
- Use "visualisation" not "visualization"
- Use "optimise" not "optimize"
- Use "centre" not "center"
- Use "behaviour" not "behavior"

## Critical Constraints

**Non-negotiable requirements:**
- Must be a static site requiring no server
- Must work completely offline (no internet connection except microsoft.com domains)
- No software installation allowed
- Must run by simply opening HTML file in Edge browser
- All dependencies must be embedded or use Microsoft CDN

## File Structure

- `index.html` - Main application file with custom editor
- `package.json` - Project metadata (for documentation only, no build process)
- `README.md` - User-facing documentation
- `LICENSE` - MIT License

## Architecture

The project contains:

1. **index.html**: Completely self-contained
   - Custom textarea-based editor
   - Zero external dependencies

### Core Components

The project contain three main systems:

1. **JSON Editor Panel** (left side)
   - Syntax-aware text editor
   - Real-time validation
   - Line numbers
   - Collapse/expand functionality
   - Optional JSON Schema validation panel

2. **Graph Visualisation Panel** (right side)
   - Custom graph rendering engine
   - SVG-based edge drawing
   - Draggable nodes
   - Zoom controls
   - Automatic layout algorithm

3. **Validation Systems**
   - Real-time JSON parsing validation
   - Optional JSON Schema validator (custom implementation)
   - Visual status indicators

### Graph Visualisation Algorithm

The `GraphVisualizer` class implements a tree layout algorithm:

- **Parsing**: Recursively traverses JSON structure, creating nodes for each key-value pair
- **Layout**: Uses depth-based horizontal positioning (levelWidth * depth) and index-based vertical positioning
- **Rendering**:
  - SVG paths for edges (curved bezier connections)
  - Absolute-positioned divs for nodes
  - Supports dragging to manually adjust positions
- **Node Types**: Identifies primitives (string, number, boolean, null), objects, and arrays

## Key Features Implementation

### JSON Validation
- Debounced validation (500ms) on editor changes
- Catches syntax errors via try-catch on `JSON.parse()`
- Updates status indicator in header
- Clears visualisation on invalid JSON

### JSON Schema Validation
- Custom minimal implementation in `JSONSchemaValidator` class
- Supports: type, required, properties, items, minimum, maximum, minLength, maxLength, pattern
- Does not support: anyOf, oneOf, allOf, $ref, or complex schema features
- Toggle visibility with "Schema Validation" button

### File Import/Export
- Import: Uses FileReader API to read .json files
- Export: Creates Blob and triggers download via temporary anchor element
- Both operations validate JSON before proceeding

### Collapse/Expand
- "Collapse All": `JSON.stringify(json)` - single line
- "Expand All": `JSON.stringify(json, null, 2)` - formatted with 2-space indent

## Development Guidelines

### Adding Features

When adding new features:

1. **No external dependencies**: All code must be inline or use Microsoft CDN
2. **Test offline**: Always verify functionality works without internet
3. **Preserve self-contained nature**: Do not split into separate CSS/JS files

### Modifying the Graph Visualisation

The layout algorithm is in `GraphVisualizer.calculateLayout()`:
- Adjust `levelWidth` to change horizontal spacing between depth levels
- Adjust `nodeHeight` to change vertical spacing between siblings
- Edge drawing is in `drawEdges()` using SVG bezier curves
- Node positioning is absolute, stored in `node.x` and `node.y`

### Extending JSON Schema Validation

The validator is intentionally minimal. To add features:
- Extend `JSONSchemaValidator.validateRecursive()` method
- Add new validation checks in the conditional blocks
- Push error messages to `errors` array with path prefix
- Follow pattern: `if (schema.newProperty) { /* validate */ }`

### Styling Changes

All CSS is inline in `<style>` tags. Key classes:
- `.node` - graph visualisation nodes
- `.edge-line` - SVG paths connecting nodes
- `#json-editor` - the textarea editor
- `.status.valid` / `.status.invalid` - validation indicators

## Common Tasks

### Creating GitHub Releases

When creating a new GitHub release, always use rich, detailed release notes following this structure:

1. **Header**: `## JSON Editor - vX.Y.Z` with brief description
2. **Installation**: Standard 3-step instructions with download filename
3. **What's New**: Detailed sections for each change with:
   - Emoji prefix for category (🐛 Bug Fix, ⚡ Performance, ✨ Feature, etc.)
   - Bold subheadings for features
   - Bullet points explaining changes
   - Code examples or tables where helpful
4. **Technical Details**: Implementation notes for developers
5. **Full Changelog**: Link to GitHub compare URL
6. **Footer**: `🤖 Generated with [Claude Code](https://claude.com/claude-code)`

**Important**: Always use `gh release edit <tag> -F <notes-file>` to update release notes from a file. Do NOT rely on inline notes which may be truncated or replaced by templates.

**Do NOT include**: A "Previous Releases" section listing older versions.

Example release notes structure:
```markdown
## JSON Editor - v1.6.1

Offline JSON editor with syntax highlighting...

### Installation
1. Download `json-editor-v1.6.1.zip`
2. Extract the archive
3. Open `index.html` in your browser

### What's New

#### 🐛 Bug Fix Title
Description of the fix...

#### ⚡ Performance Improvements
**Feature Name**
- Bullet point details
- More details

### Technical Details
- Implementation notes...

**Full Changelog**: https://github.com/JayVDZ/json-editor/compare/vX.Y.Z...vA.B.C

---

🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

### Testing Offline
1. Open `index.html` in Edge browser
2. Disconnect from internet
3. Verify all features work (edit, validate, visualise, import, export)

### Debugging Visualisation Issues
- Check browser console for JavaScript errors
- Verify JSON is valid before visualisation renders
- Check node positions: `console.log(visualizer.nodes)`
- Check SVG rendering: inspect `#edges-svg` element

### Performance Considerations
- Large JSON files (>10,000 nodes) may cause performance issues
- Debounce timers prevent excessive re-rendering
- Dragging nodes directly manipulates DOM (no re-render)
- Consider adding node limits for very large structures

## Browser Compatibility

Tested in Microsoft Edge. Should work in any modern browser supporting:
- ES6 JavaScript (arrow functions, classes, template literals)
- FileReader API
- Blob API
- SVG rendering
- CSS Flexbox

## Limitations

- Graph layout is tree-based (depth/index), not force-directed like JSONCrack
- No support for non-JSON formats (YAML, XML, CSV, TOML)
- No image export (PNG/SVG download)
- Schema validator is minimal compared to full JSON Schema spec
- No search/replace functionality
- No undo/redo (use browser's built-in for textarea)
