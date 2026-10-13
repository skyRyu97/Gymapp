# LIFTLY — MASTER UI DESIGN SYSTEM & RESPONSIVE STANDARD

> **Source of Truth:** Preserves Liftly's brand identity, official color tokens, typography, component styling, iconography, navigation, and responsive behavior across every screen.

---

## 1. Brand Identity
* **Name**: Liftly
* **Vibe**: Premium, athletic, energetic, minimal with distinctive neon accents, slightly futuristic, clean and practical.

---

## 2. Official Color Tokens

### Dark Theme (Default)
| Token | Hex Value | Usage |
| :--- | :--- | :--- |
| `--background` | `#080B0E` | Main app background canvas |
| `--surface` | `#10171D` | Standard card surface, bottom nav |
| `--surface-elevated` | `#131C23` | Sub-panels (e.g. About, Alternative chips), sheets |
| `--accent-primary` | `#C4FF5A` | Neon lime for primary actions, active day, checkmarks |
| `--accent-secondary`| `#00D9FF` | Electric cyan for secondary actions, duration pills, next arrows |
| `--text-primary` | `#F5F7FA` | High-contrast headings and primary labels |
| `--text-secondary` | `#93A7BD` | Muted blue-gray for subtitles, inactive icons, metadata |
| `--border` | `#1D3039` | Subtle structural borders |

### Light Theme
| Token | Hex Value | Usage |
| :--- | :--- | :--- |
| `--background` | `#F4F7F8` | Light canvas |
| `--surface` | `#FFFFFF` | White card surfaces |
| `--surface-elevated` | `#EDF2F4` | Elevated sub-panels |
| `--accent-primary` | `#C4FF5A` | Neon lime brand accent |
| `--accent-secondary`| `#00D9FF` | Electric cyan accent |
| `--text-primary` | `#15212A` | Dark slate text |
| `--text-secondary` | `#637585` | Medium muted slate text |
| `--border` | `#DCE5E9` | Light borders |

---

## 3. Typography & Sizing
* **Font Family**: Manrope (Primary) / Inter (Alternative).
* **Weights**: Bold for titles and primary action buttons; Semibold for section headers; Regular for body text; Medium for metadata.
* **Uppercase**: Used intentionally and sparingly for exercise names and metadata tags.

---

## 4. Component Standards

### Cards
* **Corner Radius**: Standard cards = `16–24px`; Hero feature cards = `24–30px`.
* **Outlines**: Thin borders (`#1D3039`). Green-to-cyan gradient borders reserved exclusively for hero feature cards.

### Buttons & Controls
* **Primary**: Pill or rounded (`#C4FF5A` with `#080B0E` dark text). Minimum 48px touch target.
* **Secondary**: Cyan stroke or muted dark surface.

### Navigation (Fixed Bottom Bar)
* 4 destinations: **Home**, **Schedule**, **Progress**, **Profile**.
* Active state: Neon lime icon + label + subtle glow + small underline indicator.
* Inactive state: Muted blue-gray (`#93A7BD`).

---

## 5. Responsive Standard — Samsung Galaxy S24+
* **Primary Target Viewport**: `412 × 915 CSS px` (Portrait).
* **Supported Scale**: `360 × 800` up to `412 × 892`, adapting fluidly to tablet and desktop.
* **Constraints**:
  * Safe area insets respected (`top` and `bottom`).
  * No horizontal overflow.
  * Fluid widths with clean padding scale (`space-1: 4px` to `space-8: 32px`).
  * Comfortable touch targets throughout.
