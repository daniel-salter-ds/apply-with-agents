# Reference: Build verification

Run after `./scripts/build.sh` (see [workflows/build.md](../workflows/build.md)).

## Commands

```bash
export PATH="/Library/TeX/texbin:$PATH"
./scripts/build.sh roles/<company-slug>/<role-slug> 2>&1 | grep -E "Output written|Wrote"
./scripts/output-name.sh roles/<company-slug>/<role-slug>
grep -c '\\cvevent' roles/<company-slug>/<role-slug>/resume.tex
python3 ./scripts/check-page-fill.py roles/<company-slug>/<role-slug>
test -f roles/<company-slug>/<role-slug>/resume.pdf && echo OK
```

Page count comes from the `Output written on resume.pdf (N pages, …)` line. Submission copy path is printed by `Wrote …/<Name>-<Role>-resume.pdf`.

## Checklist

- [ ] Submission PDF exists
- [ ] `resume.pdf` LaTeX artefact exists
- [ ] `cvevent` count ≥ number of Experience job headers in `resume.md`
- [ ] Page count matches budget (default two pages; user override if set)
- [ ] Final page bottom gap ≤ 5% (`check-page-fill.py` — not a fill-percentage target)
- [ ] No orphaned job headers (title on one page, dates on the next) — read PDF
- [ ] Layout pass deferred to post-draft step — see [workflows/layout.md](../workflows/layout.md); confirm with user before iterating
- [ ] Report overfull hbox warnings only if severe (likely overflow)
- [ ] Stale PDF vs markdown → rebuild with `--clean`
