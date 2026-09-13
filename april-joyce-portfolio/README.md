# April Joyce Dawal — Creative Designer Portfolio

A modern, responsive personal portfolio website for **April Joyce Dawal**, a creative and friendly designer.

Built with plain **HTML5 + Tailwind CSS (CDN) + vanilla JavaScript** — no frameworks, no build step. Open `index.html` and it just works.

---

## Quick Start

1. Double-click `index.html` or open it in any browser.
2. Optionally serve it locally:

   ```bash
   # Python
   python -m http.server 8000

   # Node (requires npx)
   npx serve .
   ```

   Then visit `http://localhost:8000`.

> The site uses the Tailwind Play CDN, Google Fonts, and Font Awesome CDN, so an internet connection is required for full styling/icons.

---

## Project Structure

```
april-joyce-portfolio/
│
├── index.html              # Entire site (markup, styles, JavaScript)
├── README.md
│
├── assets/
│   ├── images/             # Replace these with real photos/artwork
│   │   ├── profile.jpg
│   │   ├── project-1.jpg   # Social Media
│   │   ├── project-2.jpg   # Event Posters
│   │   ├── project-3.jpg   # Presentations
│   │   ├── project-4.jpg   # Promotional
│   │   ├── project-5.jpg   # Invitations
│   │   └── project-6.jpg   # Branding
│   │
│   └── icons/
│       └── favicon.svg
│
└── tools/
    └── generate-placeholder-images.ps1   # Regenerates the gradient placeholders
```

---

## Customization

### 1. Replace the images
Keep the same file names (`profile.jpg`, `project-1.jpg`, … `project-6.jpg`) and drop your real artwork into `assets/images/`. Everything else stays wired up automatically.

To regenerate the placeholder gradients (for example after changing site colors), run:

```powershell
powershell -ExecutionPolicy Bypass -File tools\generate-placeholder-images.ps1
```

### 2. Edit copy & contact details
All text lives directly in `index.html`. Search for:

| What to update | Search for |
|---|---|
| Email | `[your-email@example.com]` |
| Social media handle | `@apriljoycedawal` |
| Location | `[Your City, Country]` |
| Portfolio projects | `data-title="..."` / `data-description="..."` on each project button |

Social media icons currently link to `#` as placeholders — point them at real profile URLs.

### 3. Change colors
The palette is the default Tailwind palette plus a small config block in the `<head>`:

```html
<script>
  tailwind.config = { theme: { extend: { ... } } }
</script>
```

Primary = violet/purple, accent = pink/rose. Swap the gradient classes (e.g. `from-violet-500 to-pink-500`) to recolor any element.

### 4. Change fonts
Update the Google Fonts `<link>` and the `fontFamily` values inside `tailwind.config`.
- Headings: `font-display` (Playfair Display)
- Body: `font-body` (Poppins)

### 5. The contact form
The form is **frontend only** — it validates input and shows a simulated success toast. To actually receive messages, wire it to a free service such as [Formspree](https://formspree.io/), [Basin](https://usebasin.com/), or your own endpoint, then send the form data via `fetch` in `initContactForm()` inside the `<script>` block.

---

## Features

- Sticky glass/blur navigation with active-section highlighting + mobile hamburger menu
- Hero with gradient blobs, floating decorations, and profile card
- About, Skills, Design Philosophy, Portfolio, Why-Work-With-Me, CTA, Contact sections
- Portfolio lightbox/modal (keyboard accessible, Esc/backdrop close, focus trap)
- Contact form validation with inline errors and a simulated success notification
- Back-to-top button and auto-updating footer year
- Scroll-reveal animations that respect `prefers-reduced-motion`

## Accessibility & Performance

- Semantic HTML5 landmarks, proper heading hierarchy, descriptive alt text
- Buttons/labels with `aria-label`, `aria-expanded`, `aria-invalid`, `aria-live`
- Keyboard focus rings (`:focus-visible`) and visible error states
- `prefers-reduced-motion` fully disables smooth scrolling and reveal animations
- Lazy loading where applicable; no backend or build tooling required

---

© 2026 April Joyce Dawal. All rights reserved.