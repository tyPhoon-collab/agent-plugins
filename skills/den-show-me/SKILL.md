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
2. If Den cannot be reached, briefly explain that the interaction failed and stop. Do not generate an artifact or start a server.
3. Use `show-me` to generate one temporary HTML file. Do not save it in the repository.
4. Render Mermaid inside the HTML instead of returning it only as a code block. Load Mermaid from an available CDN or local asset with a pinned version. If rendering fails, keep the Mermaid source readable as a fallback.
5. Put HTML, text, code-shape sketches, and diagrams in the same HTML artifact. HTML-escape text before embedding it.
6. Open the temporary HTML with `den board web new <url> --json --focus`, using a `file://` URL first.
7. Leave the Board open for the user and do not immediately delete the temporary HTML. Briefly report that the Board was displayed and include its Board ID.

## Constraints

- Do not fall back to chat output when Den is unavailable.
- Create one new Web Board per invocation. Do not search for, reuse, or persist Board state.
- Do not parse or repair Mermaid syntax. Ask `show-me` to correct the content when needed.
- Do not start a publicly accessible server. If `file://` is not supported, report the failure and stop.
