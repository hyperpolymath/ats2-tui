<!-- SPDX-License-Identifier: PMPL-1.0-or-later -->
<!-- TOPOLOGY.md — Project architecture map and completion dashboard -->
<!-- Last updated: 2026-02-19 -->

# ats2-tui — Project Topology

## System Architecture

```
                        ┌─────────────────────────────────────────┐
                        │              USER / TERMINAL            │
                        │        (TUI Interface / Keyboard)       │
                        └───────────────────┬─────────────────────┘
                                            │
                                            ▼
                        ┌─────────────────────────────────────────┐
                        │           ATS2 TUI CORE                 │
                        │    (Dependent types, Logic, UI loop)    │
                        └───────────────────┬─────────────────────┘
                                            │
                                            ▼
                        ┌─────────────────────────────────────────┐
                        │           INTERFACE LAYER               │
                        │  ┌───────────┐  ┌───────────────────┐  │
                        │  │ Idris2 ABI│  │     Zig FFI       │  │
                        │  │ (Proofs)  │  │ (Memory Safety)   │  │
                        │  └─────┬─────┘  └────────┬──────────┘  │
                        └────────│─────────────────│──────────────┘
                                 │                 │
                                 ▼                 ▼
                        ┌─────────────────────────────────────────┐
                        │          SYSTEM LIBS / OS               │
                        │      (libc, ncurses/terminfo)           │
                        └─────────────────────────────────────────┘

                        ┌─────────────────────────────────────────┐
                        │          REPO INFRASTRUCTURE            │
                        │  contractiles/      ABI-FFI Standards   │
                        │  Containerfile      .machine_readable/  │
                        └─────────────────────────────────────────┘
```

## Completion Dashboard

```
COMPONENT                          STATUS              NOTES
─────────────────────────────────  ──────────────────  ─────────────────────────────────
CORE TUI
  ATS2 UI Loop                      ████░░░░░░  40%    Initial event handling active
  Widget Framework                  ██░░░░░░░░  20%    Basic text rendering
  Input Mapping                     ████░░░░░░  40%    Keyboard shortcuts defined

ABI & FFI
  Idris2 ABI (Types.idr)            ██████████ 100%    Dependent type proofs stable
  Zig FFI Bridge                    ████████░░  80%    Wait-free primitives refined
  Memory Layout Proofs              ██████████ 100%    Layout.idr verified

REPO INFRASTRUCTURE
  Containerfile                     ██████████ 100%    Reproducible build env
  .machine_readable/                ██████████ 100%    STATE.a2ml tracking
  ABI-FFI standard                  ██████████ 100%    Compliance verified

─────────────────────────────────────────────────────────────────────────────
OVERALL:                            █████░░░░░  ~50%   Core infrastructure stable, UI pending
```

## Key Dependencies

```
Idris2 ABI ──────► Zig FFI ──────► ATS2 Core ──────► TUI Render
     │               │                │
     └───────────────┴───────┬────────┴──────────────────┐
                             ▼
                        System Libs
```

## Update Protocol

This file is maintained by both humans and AI agents. When updating:

1. **After completing a component**: Change its bar and percentage
2. **After adding a component**: Add a new row in the appropriate section
3. **After architectural changes**: Update the ASCII diagram
4. **Date**: Update the `Last updated` comment at the top of this file

Progress bars use: `█` (filled) and `░` (empty), 10 characters wide.
Percentages: 0%, 10%, 20%, ... 100% (in 10% increments).
