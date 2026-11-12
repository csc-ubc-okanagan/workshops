# R Fundamentals for Data Analysis

Source files and rendered output for the **R Fundamentals** workshop series. It is published on the workshops landing page (`docs/index.md`) through GitHub Pages.

Each workshop is written once as an R Markdown file. Rendering it produces two
versions: (1) a 'flat' html file (has the suffix `-flat`) that students can use
as take home material and (2) a reactjs file (has the suffix `-js`) that are the
interactive slides.

---

## Folder layout

```
└── r-fundamentals/                 # root of r fundamentals workshops
    ├── README.md
    ├── flat.lua                    # Lua filter shared by all series (slides → flat page)
    ├── ws-descriptions/
    │   ├── series.txt                              # series blurb on the landing page
    │   ├── ws1-fundamental-concepts-with-rstudio.txt
    │   ├── ws2-importing-data.txt
    │   └── ...  # one .txt per workshop
    ├── output/                     # folder with output from knitted Rmds that you edit
    │   ├── ws1-fundamental-concepts-with-rstudio-js.html    # rendered slides
    │   ├── ws1-fundamental-concepts-with-rstudio-flat.md    # rendered flat page
    │   └── ...  # two per per workshop
    ├── ws1-fundamental-concepts-with-rstudio.Rmd   # source (edit this)
    ├── ws2-importing-data.Rmd
    ├── ... # one Rmd per workshop
    └── site_libs/                  # reveal.js + plugin files used by the -js.html slides
```
---

## Naming conventions

- **Workshop files:** `wsN-short-title.Rmd`, e.g. `ws2-importing-data.Rmd`. Use lowercase with hyphens and no spaces.
- **Rendered output:** the same base name plus `-js.html` (slides) or `-flat.md` (workshop page).
- **Descriptions:** `ws-descriptions/` contains `series.txt` plus one `.txt` per workshop, named with the **same base name** as its `.Rmd`.

> ⚠️ GitHub Pages builds on Linux and is **case-sensitive**. `Series.txt`, `series.TXT` and `series.txt` are three different files there, even though Windows treats them as one. Windows Explorer also hides extensions by default, so check that a file isn't really `series.txt.txt`.

---

## Editing workshop content

1. Edit the `.Rmd`. Do **not** hand-edit the rendered `-js.html` or `-flat.md`, because the next render overwrites them.
2. Speaker notes go in a `:::notes` block under each slide:
   ```markdown
   ## Slide title

   - bullet

   :::notes
   What the instructor says here.
   :::
   ```
To see the speakers notes version simply open `wsx-js.html` and hit `s` on your keyboard. This will
open up a speakers view (with notes visible) and a linked audience view (without notes visible).

### YAML header (template)

```yaml
---
title: "R: Workshop Title"
date: "`r format(Sys.time(), '%Y-%m-%d %H:%M:%S')`"
output:
  revealjs::revealjs_presentation:
    slide_level: 1
    reveal_plugins: ["notes"]
    self_contained: false
    smart: true
    lib_dir: site_libs
    includes:
      after_body: ../slides-css.html
  md_document:
    variant: gfm-raw_html
    pandoc_args: ["--lua-filter=../flat.lua"]
---
```

Things to avoid in the header:
- `slide_level` takes an **underscore**. `slide-level` is silently ignored.
- `scrollable` and `code-overflow` are Quarto options and do nothing here. Scrolling comes from `../slides.css`.
- `lib_dir` must be **inside** this folder. `../site_libs` fails with a `relativeTo ... does not appear to be a descendant` error.
- `reveal_plugins` (speaker notes) only works with `self_contained: false`.

---

## Rendering

Run these from R with the working directory set to `docs/r-fundamentals/`. Check with `getwd()`.

```r
f <- "ws2-importing-data"

# Slides
rmarkdown::render(paste0(f, ".Rmd"),
                  output_format = "revealjs::revealjs_presentation",
                  output_file   = paste0(f, "-js.html"))

# Flat workshop page
rmarkdown::render(paste0(f, ".Rmd"),
                  output_format = "md_document",
                  output_file   = paste0(f, "-flat.md"))
```

Output is written next to the `.Rmd`. Calling `rmarkdown::render()` without `output_format` only builds the **first** format in the YAML.

Commit the `.Rmd`, both rendered files, and any new files in `site_libs/`.

---

## Adding a new workshop

1. Create `wsN-short-title.Rmd` using the YAML template above.
2. Create `ws-descriptions/wsN-short-title.txt` with a one-paragraph description.
3. Render both formats (see above).
4. Add an entry to the R Fundamentals section of `docs/index.md`:
   ```html
   <li class="ws-item">
     <span class="ws-item-title">R: Short Title</span>
     <div class="ws-controls">
       <details class="ws-desc"><summary>Description</summary><div class="ws-desc-body">{% include_relative r-fundamentals/ws-descriptions/wsN-short-title.txt %}</div></details>
       <span class="ws-links"><a href="r-fundamentals/wsN-short-title-flat.html">workshop page</a></span>
       <span class="ws-links"><a href="r-fundamentals/wsN-short-title-js.html">slides page</a></span>
     </div>
   </li>
   ```
5. Commit and push, then check the **Actions** tab to confirm the Pages build passed.

---

## Description files

- Jekyll inserts these into `index.md` as **raw HTML** when it builds the site. Write `&amp;` for `&`, and use `<a href="...">` for links.
- Keep each to one paragraph of plain text with no Markdown.
- If a description file is missing or misnamed, the **whole site build fails** with `Could not locate the included file ...`. Run `git ls-files docs/r-fundamentals/ws-descriptions` to see exactly what's committed.