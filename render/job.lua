-- Promoted from _spike/pandoc-anthropic/job.lua
-- Converts Experience job headers to AltaCV \cvevent blocks.
-- Pattern: **{org} — {title}** · *{dates} | {location}*
-- See .cursor/plans/altacv_style_workflow/00-CONTEXT.md
--
-- Does not convert:
--   Education MEng line (section guard)
--   Industry Mentor line (no " | location" in Emph)
--   Profile / Skills paragraphs
--   Job intro paragraphs (plain text after cvevent)

local job_count = 0

local function inlines_to_text(inlines)
  return pandoc.utils.stringify(inlines)
end

local function esc_latex(s)
  s = s:gsub("\\", "\\textbackslash{}")
  s = s:gsub("&", "\\&")
  s = s:gsub("%%", "\\%%")
  s = s:gsub("#", "\\#")
  s = s:gsub("_", "\\_")
  s = s:gsub("%$", "\\$")
  s = s:gsub("{", "\\{")
  s = s:gsub("}", "\\}")
  return s
end

local function latex_en_dash_dates(dates)
  return dates:gsub("%s+-%s+", " -- ")
end

local ORG_TITLE_SEPS = { " — ", " – ", " -- " }

local function split_org_title(text)
  for _, sep in ipairs(ORG_TITLE_SEPS) do
    local pos = text:find(sep, 1, true)
    if pos then
      local org = text:sub(1, pos - 1):match("^%s*(.-)%s*$")
      local title = text:sub(pos + #sep):match("^%s*(.-)%s*$")
      if org ~= "" and title ~= "" then
        return org, title
      end
    end
  end
  return nil, nil
end

local function split_dates_location(text)
  local pos = text:find(" | ", 1, true)
  if not pos then
    return nil, nil
  end
  local dates = text:sub(1, pos - 1):match("^%s*(.-)%s*$")
  local location = text:sub(pos + 3):match("^%s*(.-)%s*$")
  if dates == "" or location == "" then
    return nil, nil
  end
  return dates, location
end

local function find_emph_index(inlines)
  for i = 2, #inlines do
    if inlines[i].t == "Emph" then
      return i
    end
  end
  return nil
end

local function parse_job_header(inlines)
  if #inlines < 3 or inlines[1].t ~= "Strong" then
    return nil
  end

  local emph_idx = find_emph_index(inlines)
  if not emph_idx then
    return nil
  end

  local org, title = split_org_title(inlines_to_text(inlines[1].c))
  if not org or not title then
    return nil
  end

  local dates, location = split_dates_location(inlines_to_text(inlines[emph_idx].c))
  if not dates or not location then
    return nil
  end

  return {
    title = title,
    org = org,
    dates = latex_en_dash_dates(dates),
    location = location,
  }
end

local function single_strong_title(inlines)
  if #inlines ~= 1 or inlines[1].t ~= "Strong" then
    return nil
  end
  return inlines_to_text(inlines[1].c)
end

local function job_to_latex(job)
  job_count = job_count + 1
  local prefix = ""
  if job_count > 1 then
    prefix = "\\divider\n\n"
  end
  return prefix
    .. "\\cvevent{"
    .. esc_latex(job.title)
    .. "}{"
    .. esc_latex(job.org)
    .. "}{"
    .. esc_latex(job.dates)
    .. "}{"
    .. esc_latex(job.location)
    .. "}{}{}\n"
end

local function transform_block(block, in_education)
  if block.t == "Para" and not in_education then
    local job = parse_job_header(block.content)
    if job then
      return pandoc.RawBlock("latex", job_to_latex(job)), in_education
    end
    local subsection = single_strong_title(block.content)
    if subsection then
      return pandoc.RawBlock("latex", "\\cvsubsection{" .. esc_latex(subsection) .. "}\n"), in_education
    end
  end
  return block, in_education
end

function Pandoc(doc)
  job_count = 0
  local in_education = false
  local blocks = {}

  for _, block in ipairs(doc.blocks) do
    if block.t == "Header" and block.level == 2 then
      local title = pandoc.utils.stringify(block.content)
      in_education = title:match("^Education") ~= nil
      table.insert(blocks, block)
    else
      local transformed, edu = transform_block(block, in_education)
      in_education = edu
      table.insert(blocks, transformed)
    end
  end

  doc.blocks = blocks
  return doc
end

return {
  { Pandoc = Pandoc },
}
