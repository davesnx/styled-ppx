#!/usr/bin/env python3
"""
CSS Parser Analysis Script

This script analyzes the Parser.re file to categorize and document all CSS rules.
It helps identify which rules belong to which categories and generates reports
for systematic reorganization.
"""

import re
import json
from typing import Dict, List, Set, Tuple
from collections import defaultdict

class CSSParserAnalyzer:
    def __init__(self, parser_file_path: str):
        self.parser_file_path = parser_file_path
        self.rules = {}
        self.properties = {}
        self.functions = {}
        self.data_types = {}
        self.vendor_prefixed = {}
        
    def analyze(self):
        """Main analysis method"""
        with open(self.parser_file_path, 'r') as f:
            content = f.read()
        
        # Extract all rule definitions
        self._extract_rules(content)
        
        # Categorize rules
        self._categorize_rules()
        
        # Generate reports
        self._generate_reports()
    
    def _extract_rules(self, content: str):
        """Extract all rule definitions from the parser file"""
        # Pattern to match rule definitions
        rule_pattern = r'and\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*\[%value\.rec\s*([^]]+)\]'
        
        matches = re.findall(rule_pattern, content, re.MULTILINE | re.DOTALL)
        
        for rule_name, rule_definition in matches:
            # Clean up the rule definition
            rule_definition = rule_definition.strip().strip('"\'')
            self.rules[rule_name] = rule_definition
    
    def _categorize_rules(self):
        """Categorize rules into different types"""
        for rule_name, rule_definition in self.rules.items():
            
            # Properties (start with property_)
            if rule_name.startswith('property_'):
                prop_name = rule_name[9:]  # Remove 'property_' prefix
                self.properties[prop_name] = {
                    'full_name': rule_name,
                    'definition': rule_definition,
                    'category': self._categorize_property(prop_name, rule_definition)
                }
            
            # Functions (start with function_)
            elif rule_name.startswith('function_'):
                func_name = rule_name[9:]  # Remove 'function_' prefix
                self.functions[func_name] = {
                    'full_name': rule_name,
                    'definition': rule_definition,
                    'category': self._categorize_function(func_name, rule_definition)
                }
            
            # Vendor prefixed rules (start with _)
            elif rule_name.startswith('_'):
                self.vendor_prefixed[rule_name] = {
                    'definition': rule_definition,
                    'vendor': self._detect_vendor(rule_name, rule_definition)
                }
            
            # Data types (everything else)
            else:
                self.data_types[rule_name] = {
                    'definition': rule_definition,
                    'category': self._categorize_data_type(rule_name, rule_definition)
                }
    
    def _categorize_property(self, prop_name: str, definition: str) -> str:
        """Categorize CSS properties by functional area"""
        
        # Vendor prefixed
        if prop_name.startswith(('_webkit_', '_moz_', '_ms_', '_o_')):
            return 'vendor'
        
        # Layout properties
        if prop_name in ['display', 'position', 'float', 'clear', 'top', 'left', 'right', 'bottom', 'z_index']:
            return 'layout/basic'
        
        if prop_name in ['width', 'height', 'min_width', 'max_width', 'min_height', 'max_height']:
            return 'layout/sizing'
        
        # Box model
        if any(x in prop_name for x in ['margin', 'padding', 'border']):
            return 'box_model'
        
        # Flexbox
        if any(x in prop_name for x in ['flex', 'align', 'justify']):
            return 'flexbox'
        
        # Grid
        if 'grid' in prop_name:
            return 'grid'
        
        # Background and borders
        if any(x in prop_name for x in ['background', 'border']):
            return 'backgrounds'
        
        # Typography
        if any(x in prop_name for x in ['font', 'text', 'line', 'letter', 'word']):
            return 'text_fonts'
        
        # Colors
        if any(x in prop_name for x in ['color', 'opacity']):
            return 'colors'
        
        # Transforms and animations
        if any(x in prop_name for x in ['transform', 'animation', 'transition']):
            return 'transforms'
        
        # Effects
        if any(x in prop_name for x in ['shadow', 'filter', 'backdrop']):
            return 'effects'
        
        # Interactions
        if any(x in prop_name for x in ['cursor', 'pointer', 'user', 'touch']):
            return 'interactions'
        
        # Media queries
        if prop_name.startswith('media_'):
            return 'media'
        
        return 'other'
    
    def _categorize_function(self, func_name: str, definition: str) -> str:
        """Categorize CSS functions by purpose"""
        
        # Math functions
        if func_name in ['calc', 'min', 'max', 'clamp']:
            return 'math'
        
        # Color functions
        if func_name in ['rgb', 'rgba', 'hsl', 'hsla', 'color_mix']:
            return 'color'
        
        # Transform functions
        if any(x in func_name for x in ['matrix', 'translate', 'rotate', 'scale', 'skew']):
            return 'transform'
        
        # Filter functions
        if any(x in func_name for x in ['blur', 'brightness', 'contrast', 'grayscale', 'hue_rotate', 'invert', 'opacity', 'saturate', 'sepia']):
            return 'filter'
        
        # Shape functions
        if func_name in ['circle', 'ellipse', 'polygon', 'inset', 'path']:
            return 'shape'
        
        # Gradient functions
        if 'gradient' in func_name:
            return 'gradient'
        
        # Grid functions
        if func_name in ['minmax', 'fit_content', 'repeat']:
            return 'grid'
        
        # Image functions
        if any(x in func_name for x in ['image', 'cross_fade']):
            return 'image'
        
        # Utility functions
        if func_name in ['attr', 'var', 'env']:
            return 'utility'
        
        # Counter functions
        if 'counter' in func_name:
            return 'counter'
        
        return 'other'
    
    def _categorize_data_type(self, type_name: str, definition: str) -> str:
        """Categorize CSS data types"""
        
        # Basic data types
        if any(x in type_name for x in ['length', 'percentage', 'number', 'integer', 'time', 'frequency', 'angle']):
            return 'basic'
        
        # Color data types
        if any(x in type_name for x in ['color', 'alpha', 'hue']):
            return 'color'
        
        # Position and sizing
        if any(x in type_name for x in ['position', 'size', 'radius']):
            return 'position'
        
        # Typography
        if any(x in type_name for x in ['font', 'text', 'line']):
            return 'typography'
        
        # Selectors
        if any(x in type_name for x in ['selector', 'combinator', 'pseudo']):
            return 'selectors'
        
        # Images and gradients
        if any(x in type_name for x in ['image', 'gradient']):
            return 'images'
        
        # Grid and layout
        if any(x in type_name for x in ['grid', 'track', 'display']):
            return 'layout'
        
        # Shapes
        if any(x in type_name for x in ['shape', 'basic_shape']):
            return 'shapes'
        
        return 'other'
    
    def _detect_vendor(self, rule_name: str, definition: str) -> str:
        """Detect vendor prefix from rule name or definition"""
        if 'webkit' in rule_name.lower() or 'webkit' in definition.lower():
            return 'webkit'
        if 'moz' in rule_name.lower() or 'moz' in definition.lower():
            return 'mozilla'
        if 'ms' in rule_name.lower() or 'ms' in definition.lower():
            return 'microsoft'
        if '_o_' in rule_name.lower() or '-o-' in definition.lower():
            return 'opera'
        return 'unknown'
    
    def _generate_reports(self):
        """Generate analysis reports"""
        
        # Summary report
        summary = {
            'total_rules': len(self.rules),
            'properties': len(self.properties),
            'functions': len(self.functions),
            'data_types': len(self.data_types),
            'vendor_prefixed': len(self.vendor_prefixed)
        }
        
        # Property categories
        prop_categories = defaultdict(list)
        for prop_name, prop_info in self.properties.items():
            prop_categories[prop_info['category']].append(prop_name)
        
        # Function categories  
        func_categories = defaultdict(list)
        for func_name, func_info in self.functions.items():
            func_categories[func_info['category']].append(func_name)
        
        # Data type categories
        type_categories = defaultdict(list)
        for type_name, type_info in self.data_types.items():
            type_categories[type_info['category']].append(type_name)
        
        # Generate markdown report
        self._generate_markdown_report(summary, prop_categories, func_categories, type_categories)
        
        # Generate JSON data for scripts
        self._generate_json_data(prop_categories, func_categories, type_categories)
    
    def _generate_markdown_report(self, summary, prop_categories, func_categories, type_categories):
        """Generate a markdown analysis report"""
        
        report = f"""# CSS Parser Analysis Report

## Summary
- **Total Rules**: {summary['total_rules']}
- **Properties**: {summary['properties']}
- **Functions**: {summary['functions']}
- **Data Types**: {summary['data_types']}
- **Vendor Prefixed**: {summary['vendor_prefixed']}

## Property Categories
"""
        
        for category, properties in sorted(prop_categories.items()):
            report += f"\n### {category.replace('_', ' ').title()} ({len(properties)} properties)\n"
            for prop in sorted(properties):
                report += f"- `{prop}`\n"
        
        report += "\n## Function Categories\n"
        for category, functions in sorted(func_categories.items()):
            report += f"\n### {category.replace('_', ' ').title()} ({len(functions)} functions)\n"
            for func in sorted(functions):
                report += f"- `{func}()`\n"
        
        report += "\n## Data Type Categories\n"
        for category, types in sorted(type_categories.items()):
            report += f"\n### {category.replace('_', ' ').title()} ({len(types)} types)\n"
            for dtype in sorted(types):
                report += f"- `<{dtype}>`\n"
        
        with open('packages/css-property-parser/lib/ANALYSIS_REPORT.md', 'w') as f:
            f.write(report)
    
    def _generate_json_data(self, prop_categories, func_categories, type_categories):
        """Generate JSON data for automated processing"""
        
        data = {
            'properties': dict(prop_categories),
            'functions': dict(func_categories),
            'data_types': dict(type_categories),
            'vendor_prefixed': list(self.vendor_prefixed.keys())
        }
        
        with open('packages/css-property-parser/lib/parser_analysis.json', 'w') as f:
            json.dump(data, f, indent=2)

if __name__ == '__main__':
    analyzer = CSSParserAnalyzer('packages/css-property-parser/lib/Parser.re')
    analyzer.analyze()
    print("Analysis complete! Check ANALYSIS_REPORT.md and parser_analysis.json")