# CSS Grammar Parser Reorganization Plan

This document outlines the systematic approach to reorganizing the large `Parser.re` file into well-organized, documented modules.

## What We've Done So Far

### ✅ Directory Structure Created
- `grammar/data_types/` - CSS data types like `<color>`, `<length>`, etc.
- `grammar/properties/` - CSS properties organized by functional area
- `grammar/functions/` - CSS functions like `calc()`, `rgb()`, etc.
- `grammar/selectors/` - CSS selectors
- `grammar/at_rules/` - @rules like @media, @supports
- `grammar/legacy/` - Vendor-prefixed and legacy properties

### ✅ Sample Modules Created
- **Colors.re** - All color-related data types with full MDN documentation
- **Math.re** - Mathematical functions (calc, min, max, clamp)
- **Color.re** - Color functions (rgb, hsl, color-mix)
- **BasicLayout.re** - Core layout properties (display, position, float, clear)

## Current Parser.re Analysis

The current `Parser.re` file contains approximately:
- **600+ CSS data types** (rules starting with lowercase)
- **300+ CSS properties** (rules starting with `property_`)
- **60+ CSS functions** (rules starting with `function_`)
- **50+ selector-related rules**
- **20+ media query rules**
- **100+ vendor-prefixed rules**

## Systematic Organization Strategy

### Phase 1: Data Types (grammar/data_types/)
Organize by CSS specification categories:

#### Basic Data Types
- **Lengths.re** - `<length>`, `<extended-length>`, `<viewport-length>`
- **Percentages.re** - `<percentage>`, `<extended-percentage>`
- **Numbers.re** - `<number>`, `<integer>`, `<ratio>`
- **Times.re** - `<time>`, `<extended-time>`
- **Frequencies.re** - `<frequency>`, `<extended-frequency>`
- **Angles.re** - `<angle>`, `<extended-angle>`
- **Resolutions.re** - `<resolution>`

#### Visual Data Types
- **Colors.re** ✅ (Already created)
- **Images.re** - `<image>`, `<gradient>`, `<bg-image>`
- **Positions.re** - `<position>`, `<bg-position>`
- **Shapes.re** - `<basic-shape>`, `<shape-box>`

#### Text and Typography
- **Typography.re** - `<font-size>`, `<font-weight>`, `<line-height>`
- **TextDecoration.re** - Text decoration related data types

#### Layout Data Types
- **Box.re** - `<box>`, `<visual-box>`
- **Display.re** - `<display-box>`, `<display-inside>`, etc.
- **Grid.re** - Grid-specific data types
- **Flex.re** - Flexbox-specific data types

### Phase 2: Functions (grammar/functions/)
Organize by functional purpose:

#### Core Functions
- **Math.re** ✅ (Already created)
- **Color.re** ✅ (Already created)
- **Transform.re** - `matrix()`, `rotate()`, `translate()`, etc.
- **Filter.re** - `blur()`, `brightness()`, `contrast()`, etc.

#### Layout Functions
- **Grid.re** - `minmax()`, `fit-content()`, `repeat()`
- **Shape.re** - `circle()`, `ellipse()`, `polygon()`, `path()`

#### Utility Functions
- **Content.re** - `attr()`, `counter()`, `var()`
- **Image.re** - `image()`, `image-set()`, `cross-fade()`

### Phase 3: Properties (grammar/properties/)
Organize by CSS specification modules:

#### Layout Properties
- **BasicLayout.re** ✅ (Already created)
- **Positioning.re** - `top`, `left`, `right`, `bottom`, `z-index`
- **Sizing.re** - `width`, `height`, `min-width`, `max-width`
- **BoxModel.re** - `margin`, `padding`, `border`

#### Flexbox and Grid
- **Flexbox.re** - All flex-related properties
- **Grid.re** - All grid-related properties

#### Visual Properties
- **Backgrounds.re** - All background-related properties  
- **Borders.re** - All border-related properties
- **Colors.re** - `color`, `opacity`
- **Effects.re** - `box-shadow`, `filter`, `backdrop-filter`

#### Typography
- **Fonts.re** - `font-family`, `font-size`, `font-weight`, etc.
- **Text.re** - `text-align`, `text-decoration`, `line-height`, etc.

#### Interactions and Animations
- **Transitions.re** - All transition properties
- **Animations.re** - All animation properties
- **Transforms.re** - All transform properties
- **Interactions.re** - `cursor`, `pointer-events`, `user-select`

#### Vendor-Specific
- **Webkit.re** - All `-webkit-` prefixed properties
- **Mozilla.re** - All `-moz-` prefixed properties
- **Legacy.re** - Deprecated properties

### Phase 4: Selectors (grammar/selectors/)
- **Basic.re** - Type, class, ID selectors
- **Pseudo.re** - Pseudo-classes and pseudo-elements
- **Combinators.re** - Selector combinators
- **Complex.re** - Complex and compound selectors

### Phase 5: At-Rules (grammar/at_rules/)
- **Media.re** - Media query rules and features
- **Supports.re** - Feature queries
- **Container.re** - Container queries

## Implementation Guidelines

### Documentation Standards
Each module should:
1. Include comprehensive JSDoc-style comments
2. Link to relevant MDN documentation
3. Explain the purpose and usage of each rule
4. Note any browser compatibility issues
5. Include examples where helpful

### Example Documentation Format
```reason
/**
 * property-name property
 * 
 * Brief description of what this property does and its purpose.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/property-name
 */
and property_name = [%value.rec "..."];
```

### Validation
After each module is created:
1. Verify all rules are syntactically correct
2. Check that MDN links are valid and current
3. Ensure grammar specifications match current CSS standards
4. Test that the module compiles correctly

## Migration Process

1. **Create module files** one category at a time
2. **Extract rules** from the main Parser.re file
3. **Add comprehensive documentation** with MDN links
4. **Validate grammar specifications** against current CSS standards
5. **Update main Parser.re** to import the new modules
6. **Test compilation** and functionality
7. **Remove migrated rules** from the original file

## Benefits of This Organization

1. **Maintainability** - Easier to find and update specific CSS rules
2. **Documentation** - Comprehensive MDN links and explanations
3. **Modularity** - Clean separation of concerns
4. **Discoverability** - Logical organization makes it easy to find rules
5. **Correctness** - Systematic review ensures grammar matches CSS specs
6. **Extensibility** - Easy to add new CSS features as they're standardized

## Next Steps

1. Continue with the **Data Types** phase
2. Create scripts to automate rule extraction and validation
3. Set up automated testing for each module
4. Create comprehensive module index files
5. Update build system to handle the new structure