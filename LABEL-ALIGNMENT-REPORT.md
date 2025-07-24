# Label Alignment Report - Gemini REPL Projects

## Current State Analysis

### Priority Labels Across Repos

| Repository | Priority Label Style | Labels Found |
|------------|---------------------|--------------|
| gemini-repl | Simple | `high-priority` (#FF0000) |
| gemini-repl-001 | None | - |
| gemini-repl-002 | None | - |
| gemini-repl-003 | None | - |
| gemini-repl-004 | None | - |
| gemini-repl-005 | Simple | `high-priority` (#B60205) |
| gemini-repl-006 | None | - |
| gemini-repl-007 | None | - |
| gemini-repl-008 | Structured | `priority:critical`, `priority:high`, `priority:medium`, `priority:low` |

### Status Labels Across Repos

| Repository | Status Labels |
|------------|--------------|
| gemini-repl | None found |
| gemini-repl-001 | None found |
| gemini-repl-002 | None found |
| gemini-repl-003 | None found |
| gemini-repl-004 | None found |
| gemini-repl-005 | None found |
| gemini-repl-006 | None found |
| gemini-repl-007 | None found |
| gemini-repl-008 | `status:in-progress`, `status:blocked`, `status:needs-review`, `status:ready`, `status:wont-fix` |

### Meta/Observer Labels

| Repository | Meta Label | Observer Label |
|------------|------------|----------------|
| gemini-repl | - | - |
| gemini-repl-001 | - | - |
| gemini-repl-002 | - | - |
| gemini-repl-003 | `meta` (#808080) | - |
| gemini-repl-004 | - | - |
| gemini-repl-005 | `meta` (#E99695) | `observer` (#0E8A16) |
| gemini-repl-006 | - | - |
| gemini-repl-007 | - | - |
| gemini-repl-008 | - | - |

## Inconsistencies Found

1. **Priority Labels**:
   - Only 3 repos have priority labels (gemini-repl, gemini-repl-005, gemini-repl-008)
   - Different styles: simple `high-priority` vs structured `priority:*`
   - Different colors for same concept (#FF0000 vs #B60205)

2. **Status Labels**:
   - Only gemini-repl-008 has structured status labels
   - No status tracking in other repos

3. **Meta/Observer Labels**:
   - Inconsistent colors for `meta` label (#808080 vs #E99695)
   - Only gemini-repl-005 has `observer` label
   - Different descriptions for similar concepts

## Recommended Alignment

### Proposed Standard Labels

#### Priority Labels (Structured)
- `priority:critical` - Critical priority - blocks release (#b60205)
- `priority:high` - High priority (#ff9f1c)
- `priority:medium` - Medium priority (#ffcc00)
- `priority:low` - Low priority (#c5def5)

#### Status Labels
- `status:in-progress` - Work in progress (#1d76db)
- `status:blocked` - Blocked by external factors (#d93f0b)
- `status:needs-review` - Needs code review (#006b75)
- `status:ready` - Ready for implementation (#0e8a16)
- `status:wont-fix` - Will not be worked on (#ffffff)

#### Meta Labels
- `meta` - Meta-level repository concerns, tooling, and analysis (#E99695)
- `observer` - Observer agent reports and analysis (#0E8A16)

## Implementation Plan

1. **Phase 1**: Document current state (this report)
2. **Phase 2**: Create tracking issue in primary repo
3. **Phase 3**: Gradually align labels across repos as they're actively used
4. **Phase 4**: Update contributing guidelines with label standards

## Notes

- gemini-repl-008 has the most comprehensive labeling system
- Earlier repos (001-004) have minimal labels, suggesting they're archived or experimental
- gemini-repl-005 introduced meta/observer labels for agent-based development
- Priority should be on active repos (gemini-repl, 005, 007, 008)