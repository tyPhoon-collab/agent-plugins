---
name: den-show-me
description: Render show-me visual explanations as temporary HTML and display them in a Den Web Board. Use when the user asks to see a show-me result in Den or on a Board.
---

# den-show-me

Render `show-me` results as temporary HTML and display them in a Den Web Board. Let `show-me` decide what to visualize; this skill only handles the display destination.

## Prerequisites

- The `show-me` skill
- The `den` skill

## Procedure

1. Run `den health --json` first.
2. If Den cannot be reached, briefly explain that the interaction failed and stop. Do not generate an artifact.
3. Use `show-me` to generate a single temporary HTML file at `/tmp/<unique>.html`, combining all output into it and HTML-escaping any embedded text.
4. Render Mermaid inside the HTML instead of returning it only as a code block. Load Mermaid from an available CDN or local asset with a pinned version. If rendering fails, keep the Mermaid source readable as a fallback.
5. Open the temporary HTML with `den board web new <url> --json`, using a `file://` URL. Add `--focus` only when the user explicitly asks to bring the Board to the front.
6. Leave the Board open for the user and do not immediately delete the temporary HTML. Briefly report that the Board was displayed and include its Board ID.
