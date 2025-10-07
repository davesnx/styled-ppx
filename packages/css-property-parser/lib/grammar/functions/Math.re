/**
 * CSS Math Functions
 * 
 * This module defines CSS mathematical functions for calculations and value manipulation.
 * 
 * References:
 * - CSS Values and Units Module: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Functions#math_functions
 * - calc(): https://developer.mozilla.org/en-US/docs/Web/CSS/calc
 * - min(): https://developer.mozilla.org/en-US/docs/Web/CSS/min
 * - max(): https://developer.mozilla.org/en-US/docs/Web/CSS/max
 * - clamp(): https://developer.mozilla.org/en-US/docs/Web/CSS/clamp
 */

/**
 * calc() function
 * 
 * Performs calculations to determine CSS property values.
 * Allows mixing different units and using mathematical operations.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/calc
 */
let rec function_calc = [%value.rec "calc( <calc-sum> )"];

/**
 * min() function
 * 
 * Returns the smallest value from a list of comma-separated values.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/min
 */
and function_min = [%value.rec "min( [ <calc-sum> ]# )"];

/**
 * max() function
 * 
 * Returns the largest value from a list of comma-separated values.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/max
 */
and function_max = [%value.rec "max( [ <calc-sum> ]# )"];

/**
 * clamp() function
 * 
 * Clamps a value between an upper and lower bound.
 * Takes exactly three parameters: minimum, preferred, and maximum values.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/clamp
 */
and function_clamp = [%value.rec "clamp( [ <calc-sum> ]#{3} )"];

/**
 * Calculation sum
 * 
 * Represents a sum expression within calc() functions, supporting addition and subtraction.
 * Used internally by calc(), min(), max(), and clamp() functions.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/calc#syntax
 */
and calc_sum = [%value.rec "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"];

/**
 * Calculation product
 * 
 * Represents a product expression within calc() functions, supporting multiplication and division.
 * Used internally by calc() functions for mathematical operations.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/calc#syntax
 */
and calc_product = [%value.rec "<calc-value> [ '*' <calc-value> | '/' <number> ]*"];

/**
 * Calculation value
 * 
 * Represents a value that can be used in calc() expressions.
 * Includes numbers, lengths, percentages, angles, times, and nested calculations.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/calc#syntax
 */
and calc_value = [%value.rec
  "<number> | <extended-length> | <extended-percentage> | <extended-angle> | <extended-time> | '(' <calc-sum> ')'"
];