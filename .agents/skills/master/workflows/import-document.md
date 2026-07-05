# Workflow: Import document

## 1. Receive

User uploads or pastes CV, bio, or LinkedIn export.

## 2. Save

Write to `inputs/master/` (gitignored) with dated filename if file upload.

## 3. Extract and merge

- Parse facts into structured outline
- Compare with existing `master.md`
- Present conflicts; user resolves

## 4. Update master.md

Merge approved facts. Follow master-sync rules.

## 5. Offer gap review

Optional: compare master against `config/target-role-research.md` open questions.
