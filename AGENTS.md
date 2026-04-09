# AGENTS.md
Config documents: `https://neovim.io/doc/user/`

## Scope
- This repo is a standalone Neovim config (no app/runtime tests, no CI workflow, no package manager manifest).
- `init.lua` is the real entrypoint: it loads `myconfig` first, bootstraps `lazy.nvim` if missing, then imports plugin specs.

## Code Layout That Matters
- Core editor behavior lives in `lua/myconfig/` (`remap.lua`, `options.lua`, `filetype.lua`).
- Plugin specs are loaded via lazy imports from:
  - `lua/myconfig/plugins`
  - `lua/myconfig/plugins/lsp`
- LSP server configs are split by runtime path:
  - `lsp/*.lua` for base configs
  - `after/lsp/*.lua` for overrides/extensions
- Custom colorscheme is `darcula-solid` from `lua/lush_theme/darcula-solid.lua`, activated by `lua/myconfig/plugins/colors.lua`.

