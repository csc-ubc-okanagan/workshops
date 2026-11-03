-- flat.lua: reshape the slide deck into a web page like the other workshop pages.
-- Used only by the md_document output; the revealjs slides never see it.

-- Drop speaker notes; unwrap every other div (e.g. .columns) so its contents
-- render as normal markdown on the website.
function Div(el)
  if el.classes:includes("notes") then
    return {}
  end
  return el.content
end

-- Slide separators (---) become nothing instead of horizontal lines.
function HorizontalRule()
  return {}
end

-- Slide titles (#) become sections (##) under the page title.
function Header(el)
  el.level = el.level + 1
  return el
end

-- Put the YAML title at the top of the page as the single H1.
function Pandoc(doc)
  if doc.meta.title then
    table.insert(doc.blocks, 1,
      pandoc.Header(1, pandoc.utils.stringify(doc.meta.title)))
  end
  return doc
end