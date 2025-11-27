# Multiple Visualization Types - Implementation Plan

## Current State

The application currently has a basic **hierarchical tree graph** visualization:
- SVG-based edges with bezier curves
- Absolute-positioned div nodes
- Depth-based horizontal layout
- Draggable nodes
- Implemented in `GraphVisualizer` class in `index.html`

## Context & Constraints

- **Must work offline**: All libraries must be embedded or loaded from Microsoft CDN
- **No server required**: Static HTML file only
- **No build process**: Direct file editing only
- **Self-contained**: Everything in `index.html`
- **British English**: Use visualisation (not visualization) in user-facing text

## Priority Recommendations (Implement First)

### 1. Force-Directed Graph (D3.js) - HIGH PRIORITY
**Why**: Most significant upgrade from current tree layout. Shows relationships beautifully with physics-based positioning. This is what JSONCrack uses.

**Implementation**:
- **Library**: D3.js v7 (~250KB)
- **CDN**: `https://cdn.jsdelivr.net/npm/d3@7` or embed directly
- **Features to implement**:
  - Force simulation with charge, link, and collision forces
  - Draggable nodes with alpha restart
  - Zoom and pan
  - Color-coded by type (object, array, primitive)
  - Curved edges between parent-child relationships
- **Class name**: `D3ForceGraphVisualizer`
- **Complexity**: Medium (D3 force simulation requires understanding of tick updates)
- **Estimated effort**: 3-4 hours

**Key D3 APIs**:
```javascript
d3.forceSimulation(nodes)
  .force("link", d3.forceLink(links))
  .force("charge", d3.forceManyBody())
  .force("center", d3.forceCenter())
```

---

### 2. Treemap (D3.js) - HIGH PRIORITY
**Why**: Excellent for understanding data structure and proportions. Shows relative sizes of objects/arrays. Very intuitive.

**Implementation**:
- **Library**: D3.js v7 (same as above)
- **Features to implement**:
  - Nested rectangles representing hierarchy
  - Size based on: string length, array count, object key count
  - Color-coded by type and depth
  - Click to zoom into subtrees
  - Breadcrumb navigation to zoom out
  - Tooltips showing key/value
- **Class name**: `D3TreemapVisualizer`
- **Complexity**: Low-Medium
- **Estimated effort**: 2-3 hours

**Key D3 APIs**:
```javascript
d3.treemap()
  .size([width, height])
  .padding(1)
```

---

### 3. Collapsible Tree View - MEDIUM PRIORITY
**Why**: Most familiar to developers (like browser DevTools). Excellent for navigation and exploration. Very lightweight.

**Implementation**:
- **Library**: Plain HTML/CSS or D3.js tree
- **Features to implement**:
  - Expandable/collapsible nodes (▶/▼ icons)
  - Indentation showing hierarchy
  - Click to expand/collapse
  - Expand all / Collapse all buttons
  - Search/filter functionality
  - Copy node value to clipboard
  - Show data types and counts
- **Class name**: `TreeViewVisualizer`
- **Complexity**: Low (can use native HTML `<details>` elements or custom implementation)
- **Estimated effort**: 2-3 hours

**Structure**:
```html
<ul class="tree-view">
  <li>
    <span class="toggle">▼</span>
    <span class="key">root</span>:
    <span class="type">Object {3}</span>
    <ul class="children">...</ul>
  </li>
</ul>
```

---

### 4. Table View - MEDIUM PRIORITY
**Why**: Perfect for array-based JSON (API responses, data exports). Most users are familiar with tables. Very useful for homogeneous data.

**Implementation**:
- **Library**: Plain HTML or D3.js (optional)
- **Features to implement**:
  - Detect when JSON root is array of objects
  - Auto-generate columns from object keys
  - Sortable columns (click header to sort)
  - Filter/search rows
  - Handle nested objects (show as JSON string or expand)
  - Export visible rows as CSV
  - Pagination for large datasets
- **Class name**: `TableViewVisualizer`
- **Complexity**: Low-Medium
- **Estimated effort**: 2-3 hours

**Detection logic**:
```javascript
if (Array.isArray(json) && json.length > 0 && typeof json[0] === 'object') {
  // Show table view as primary option
}
```

---

## Additional Visualization Options (Lower Priority)

### 5. Sunburst Diagram (D3.js)
**Why**: Beautiful circular hierarchy. Very space-efficient for deep nesting.

**Implementation**:
- Concentric circles, each ring = depth level
- Arc size = proportion of children
- Click to zoom into segments
- Color gradient by depth
- **Complexity**: Medium-High
- **Estimated effort**: 3-4 hours

---

### 6. Circle Packing (D3.js)
**Why**: Visually appealing. Shows hierarchy and relative sizes clearly.

**Implementation**:
- Nested circles
- Size = data volume
- Zoom by clicking circles
- **Complexity**: Low-Medium
- **Estimated effort**: 2 hours

---

### 7. Icicle/Partition Chart (D3.js)
**Why**: Good for deep structures. Shows hierarchy as stacked horizontal bars.

**Implementation**:
- Horizontal bars
- Width = proportion
- Click to drill down
- **Complexity**: Low-Medium
- **Estimated effort**: 2 hours

---

### 8. Radial Tree (D3.js)
**Why**: More compact than hierarchical tree. Good for wide structures.

**Implementation**:
- Tree arranged in circle
- Root at centre
- Children radiating outward
- **Complexity**: Medium
- **Estimated effort**: 2-3 hours

---

### 9. Indented Text View
**Why**: Copyable, searchable, lightweight. Like `tree` command output.

**Implementation**:
- Use unicode tree characters (├─, └─, │)
- Plain text or pre-formatted
- Syntax highlighting optional
- **Complexity**: Low
- **Estimated effort**: 1-2 hours

---

### 10. Horizontal Tree
**Why**: Better for wide structures. Same as current but rotated 90°.

**Implementation**:
- Modify existing `GraphVisualizer`
- Left-to-right layout
- **Complexity**: Low
- **Estimated effort**: 1 hour

---

## Library Information

### D3.js v7
- **Size**: ~250KB minified
- **CDN Options**:
  - Microsoft: Check if available
  - jsDelivr: `https://cdn.jsdelivr.net/npm/d3@7`
  - Embedded: Download and include in `<script>` tag
- **Documentation**: https://d3js.org
- **Usage**: Nearly all advanced visualizations can use D3

### Alternative Libraries (if needed)

**Vis.js Network** (~500KB)
- Specialized for network graphs
- Simpler API than D3 for force-directed graphs
- https://visjs.github.io/vis-network/docs/network/

**Cytoscape.js** (~1MB)
- Very powerful graph library
- Advanced layout algorithms
- https://js.cytoscape.org/

**ECharts** (~1MB)
- Good for traditional charts (if JSON contains time-series data)
- https://echarts.apache.org/

---

## Implementation Strategy

### Phase 1: Infrastructure (Complete First)
1. **Add D3.js library**
   - Download D3.js v7 minified
   - Embed in `<script>` tag in `index.html` or use CDN
   - Test that it loads offline

2. **Create visualizer architecture**
   - Abstract base class or interface for visualizers
   - Each visualizer implements: `render(json)`, `clear()`, `destroy()`
   - Shared container in visualization panel

3. **Add visualization switcher UI**
   - Dropdown or button group in visualization panel header
   - Options: "Graph", "Force Graph", "Treemap", "Tree View", "Table"
   - Persist selection in localStorage
   - Show/hide relevant controls per visualizer

### Phase 2: Implement Priority Visualizations
1. Force-Directed Graph (D3.js)
2. Treemap (D3.js)
3. Collapsible Tree View
4. Table View

### Phase 3: Polish & UX
1. Add visualization-specific controls (zoom, layout options)
2. Smooth transitions when switching visualizations
3. Handle edge cases (very large JSON, deeply nested structures)
4. Performance testing with large datasets
5. Add tooltips and help text

### Phase 4: Additional Visualizations (Optional)
1. Implement remaining visualizations based on user feedback
2. Consider usage analytics (if offline) to prioritize

---

## Code Structure Recommendations

### Visualizer Base Pattern
```javascript
class BaseVisualizer {
  constructor(container) {
    this.container = container;
  }

  render(json) {
    // Parse JSON and render visualization
  }

  clear() {
    // Clear visualization
  }

  destroy() {
    // Clean up event listeners, etc.
  }
}

class D3ForceGraphVisualizer extends BaseVisualizer {
  render(json) {
    // D3 force graph implementation
  }
}
```

### Switcher Implementation
```javascript
const visualizers = {
  'graph': new GraphVisualizer(container),
  'force': new D3ForceGraphVisualizer(container),
  'treemap': new D3TreemapVisualizer(container),
  'tree': new TreeViewVisualizer(container),
  'table': new TableViewVisualizer(container)
};

let currentVisualizer = 'graph';

function switchVisualizer(type) {
  visualizers[currentVisualizer].clear();
  currentVisualizer = type;
  visualizers[type].render(currentJSON);
  localStorage.setItem('visualizer', type);
}
```

### UI Addition
```html
<div class="visualizer-controls">
  <label>Visualisation:</label>
  <select id="visualizer-select">
    <option value="graph">Graph View</option>
    <option value="force">Force-Directed Graph</option>
    <option value="treemap">Treemap</option>
    <option value="tree">Tree View</option>
    <option value="table">Table View</option>
  </select>
</div>
```

---

## Testing Checklist

For each visualization:
- [ ] Works offline (disconnect internet and test)
- [ ] Handles empty JSON `{}`
- [ ] Handles deeply nested structures (10+ levels)
- [ ] Handles large arrays (1000+ items)
- [ ] Handles all primitive types (string, number, boolean, null)
- [ ] Handles mixed types in arrays
- [ ] Responsive to window resize
- [ ] Accessible (keyboard navigation where applicable)
- [ ] Performance is acceptable (<2s render for 5000 nodes)

---

## Success Criteria

The implementation is complete when:
1. At least 4 visualization types are implemented and working
2. User can switch between visualizations seamlessly
3. All visualizations work completely offline
4. Selection persists across page reloads
5. Performance is acceptable for typical JSON files (< 10MB)
6. All visualizations follow British English spelling conventions
7. Code is well-documented with comments

---

## Notes for Future Sessions

- Current implementation is in `index.html` with `GraphVisualizer` class
- Graph visualization panel is on the right side, editor on left
- JSON is validated before visualization renders
- Use `visualizeJSON()` function as entry point
- All CSS is inline in `<style>` tags
- Use British English spellings in all user-facing text (visualisation, colour, etc.)
