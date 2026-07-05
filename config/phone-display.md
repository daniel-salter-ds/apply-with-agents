# Phone display rules

Resume YAML `phone` is copied from `config/profile.yaml` on the happy path.

## Happy path (default for first users)

When home country, phone country code, and job-search country all match:

- Copy `candidate.phone` from profile to resume YAML **verbatim** (local format).
- No per-role phone logic required.

## International (optional, dormant)

Enable only when `candidate.apply_internationally: true` in profile, or when job country clearly differs from phone country:

| Condition | Resume YAML `phone` |
|-----------|---------------------|
| Job country = phone country | Local format from profile |
| Job country ≠ phone country | `candidate.phone_e164` or international format |

Setup derives `phone_e164` from the user's full number. Do not ask about international display during initial setup unless the user indicates cross-border search.
