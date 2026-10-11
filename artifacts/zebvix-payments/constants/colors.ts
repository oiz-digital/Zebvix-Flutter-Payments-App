/**
 * Semantic design tokens for the mobile app.
 *
 * These tokens mirror the naming conventions used in web artifacts (index.css)
 * so that multi-artifact projects share a cohesive visual identity.
 *
 * Replace the placeholder values below with values that match the project's
 * brand. If a sibling web artifact exists, read its index.css and convert the
 * HSL values to hex so both artifacts use the same palette.
 *
 * To add dark mode, add a `dark` key with the same token names.
 * The useColors() hook will automatically pick it up.
 */

const colors = {
  light: {
    // Legacy aliases (kept for backward compatibility)
    text: '#073D2D',
    tint: '#079758',

    // Core surfaces
    background: '#F2FFF8',
    foreground: '#073D2D',

    // Cards / elevated surfaces
    card: '#E6F8ED',
    cardForeground: '#073D2D',

    // Primary action color (buttons, links, active states)
    primary: '#079758',
    primaryForeground: '#ffffff',

    // Secondary / less-emphasis interactive surfaces
    secondary: '#DDF5E7',
    secondaryForeground: '#164D39',

    // Muted / subdued elements (dividers, timestamps, placeholders)
    muted: '#EAF8F0',
    mutedForeground: '#5B786B',

    // Accent highlights (badges, selected items, focus rings)
    accent: '#C8F4DA',
    accentForeground: '#075438',

    // Destructive actions (delete, error states)
    destructive: '#ef4444',
    destructiveForeground: '#ffffff',

    // Borders and input outlines
    border: '#BFE8D0',
    input: '#BFE8D0',
  },
  dark: {
    text: '#E6FFF0',
    tint: '#61DB98',
    background: '#06261C',
    foreground: '#E6FFF0',
    card: '#10392A',
    cardForeground: '#E6FFF0',
    primary: '#38C77B',
    primaryForeground: '#032317',
    secondary: '#164431',
    secondaryForeground: '#D7F8E4',
    muted: '#123426',
    mutedForeground: '#A0C9AF',
    accent: '#1A563B',
    accentForeground: '#D8F9E4',
    destructive: '#F16C6C',
    destructiveForeground: '#260808',
    border: '#285B42',
    input: '#285B42',
  },

  // Border radius (in px). Sync from the sibling web artifact's --radius
  // CSS variable. This value applies to cards, buttons, inputs, and modals.
  radius: 18,
};

export default colors;
