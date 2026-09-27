-- Amber Glow NVIM Config (1980s Amdek 300A inspired)

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- Amber Glow Colorscheme
        local colors = {
          bg           = "#050007", -- Deep black with purple tint
          fg           = "#e49800", -- Amber (main theme color)
          primary      = "#ffc34c", -- Light amber (keywords, directories)
          secondary    = "#7399b4", -- Steel cyan (types, accents)
          success      = "#008000", -- Green (diffs, success)
          danger       = "#9100eb", -- Purple (errors, warnings)
          warning      = "#d0d050", -- Olive/yellow (headers, active files)
          info         = "#7399b4", -- Steel cyan
          escape       = "#7fa8c6", -- String escapes (10% brighter steel)
          cyan         = "#00ffff", -- __name__ / __file__
          light        = "#fafafa", -- Bright white
          dark         = "#030005", -- Darker background variant
          muted        = "#4a4a00", -- Dark olive (line numbers)
          comment      = "#314b5c", -- Comments
          gray         = "#c6c6c6", -- Gray (operators, delimiters)
          brightPurple = "#b840ff", -- Bright purple
          brightGreen  = "#00bf00", -- Bright green
          brightYellow = "#f0f070", -- Bright yellow
          bracket      = "#7399b4", -- Brackets []
          curly        = "#ef0000", -- Curly braces {}
          paren        = "#fafafa", -- Parentheses ()
          string       = "#008000", -- Quoted strings
          func         = "#9800e4", -- def / function names
          selection    = "#2b174a", -- Visual selection
        }

        vim.cmd("highlight clear")
        vim.cmd("set termguicolors")

        vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
        vim.api.nvim_set_hl(0, "Comment", { fg = colors.comment })
        vim.api.nvim_set_hl(0, "Constant", { fg = colors.secondary })
        vim.api.nvim_set_hl(0, "String", { fg = colors.string })
        vim.api.nvim_set_hl(0, "Character", { fg = colors.string })
        vim.api.nvim_set_hl(0, "Number", { fg = colors.brightYellow })
        vim.api.nvim_set_hl(0, "Boolean", { fg = colors.brightPurple, bold = true })
        vim.api.nvim_set_hl(0, "Float", { fg = colors.brightYellow })
        vim.api.nvim_set_hl(0, "Identifier", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "Function", { fg = colors.func, bold = true })
        vim.api.nvim_set_hl(0, "Statement", { fg = colors.primary, bold = true })
        vim.api.nvim_set_hl(0, "Conditional", { fg = colors.primary })
        vim.api.nvim_set_hl(0, "Repeat", { fg = colors.primary })
        vim.api.nvim_set_hl(0, "Label", { fg = colors.warning })
        vim.api.nvim_set_hl(0, "Operator", { fg = colors.gray })
        vim.api.nvim_set_hl(0, "Keyword", { fg = colors.primary, bold = true })
        vim.api.nvim_set_hl(0, "Exception", { fg = colors.danger })
        vim.api.nvim_set_hl(0, "PreProc", { fg = colors.secondary })
        vim.api.nvim_set_hl(0, "Include", { fg = colors.primary })
        vim.api.nvim_set_hl(0, "Define", { fg = colors.secondary })
        vim.api.nvim_set_hl(0, "Macro", { fg = colors.warning })
        vim.api.nvim_set_hl(0, "PreCondit", { fg = colors.secondary })
        vim.api.nvim_set_hl(0, "Type", { fg = colors.secondary })
        vim.api.nvim_set_hl(0, "StorageClass", { fg = colors.primary })
        vim.api.nvim_set_hl(0, "Structure", { fg = colors.secondary })
        vim.api.nvim_set_hl(0, "Typedef", { fg = colors.secondary })
        vim.api.nvim_set_hl(0, "Special", { fg = colors.info })
        vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors.escape })
        vim.api.nvim_set_hl(0, "Tag", { fg = colors.warning })
        vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.gray })
        vim.api.nvim_set_hl(0, "SpecialComment", { fg = colors.comment })
        vim.api.nvim_set_hl(0, "Debug", { fg = colors.danger })

        vim.api.nvim_set_hl(0, "DelimiterCurly", { fg = colors.curly })
        vim.api.nvim_set_hl(0, "DelimiterSquare", { fg = colors.bracket })
        vim.api.nvim_set_hl(0, "DelimiterParen", { fg = colors.paren })
        vim.api.nvim_set_hl(0, "AmberDunder", { fg = colors.cyan })
        vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors.paren })
        vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors.gray })
        vim.api.nvim_set_hl(0, "@punctuation.special", { fg = colors.gray })
        vim.api.nvim_set_hl(0, "MatchParen", { fg = colors.brightYellow, bg = colors.muted, bold = true })

        local delim_ns = vim.api.nvim_create_namespace("amber_delims")
        local function color_delims(buf)
          if not vim.api.nvim_buf_is_valid(buf) then
            return
          end
          vim.api.nvim_buf_clear_namespace(buf, delim_ns, 0, -1)
          local ok, parser = pcall(vim.treesitter.get_parser, buf)
          if not ok or not parser then
            return
          end
          local function paint(pr)
            for _, tree in ipairs(pr:trees()) do
              local query = vim.treesitter.query.get(pr:lang(), "highlights")
              if query then
                for id, node in query:iter_captures(tree:root(), buf, 0, -1) do
                  local name = query.captures[id]
                  if name then
                    local text = vim.treesitter.get_node_text(node, buf)
                    local hl
                    if name:find("punctuation", 1, true) then
                      if text == "{" or text == "}" then
                        hl = "DelimiterCurly"
                      elseif text == "[" or text == "]" then
                        hl = "DelimiterSquare"
                      elseif text == "(" or text == ")" then
                        hl = "DelimiterParen"
                      end
                    elseif name:find("variable", 1, true)
                      and not name:find("string", 1, true)
                      and not name:find("comment", 1, true)
                      and text:match("^__[%w]+__$") then
                      hl = "AmberDunder"
                    end
                    if hl then
                      local srow, scol, erow, ecol = node:range()
                      vim.api.nvim_buf_set_extmark(buf, delim_ns, srow, scol, {
                        end_row = erow,
                        end_col = ecol,
                        hl_group = hl,
                        priority = 220,
                      })
                    end
                  end
                end
              end
            end
            for _, child in pairs(pr:children()) do
              paint(child)
            end
          end
          pcall(paint, parser)
        end
        local pending = {}
        vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI", "InsertLeave" }, {
          group = vim.api.nvim_create_augroup("AmberDelims", { clear = true }),
          callback = function(ev)
            pending[ev.buf] = true
            vim.defer_fn(function()
              if pending[ev.buf] then
                pending[ev.buf] = nil
                color_delims(ev.buf)
              end
            end, 60)
          end,
        })
        color_delims(vim.api.nvim_get_current_buf())

        -- UI Elements
        -- Deferred to override plugin defaults
        vim.defer_fn(function()
          vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#ef0000" })
          vim.api.nvim_set_hl(0, "IblScope", { fg = "#ef0000" })
          vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#ef0000" })
          vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#ef0000" })
          vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = "#ef0000" })
        end, 100)
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1e1e1e" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.fg, bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { fg = colors.muted })
        vim.api.nvim_set_hl(0, "Visual", { bg = colors.selection })
        vim.api.nvim_set_hl(0, "VisualNOS", { bg = colors.selection })

        vim.api.nvim_set_hl(0, "@comment", { fg = colors.comment })
        vim.api.nvim_set_hl(0, "@comment.documentation", { fg = colors.comment })
        vim.api.nvim_set_hl(0, "@string", { fg = colors.string })
        vim.api.nvim_set_hl(0, "@string.documentation", { fg = colors.string })
        vim.api.nvim_set_hl(0, "@string.python", { fg = colors.string })
        vim.api.nvim_set_hl(0, "@string.escape", { fg = colors.escape })
        vim.api.nvim_set_hl(0, "@keyword.function", { fg = colors.func, bold = true })
        vim.api.nvim_set_hl(0, "@function", { fg = colors.func, bold = true })
        vim.api.nvim_set_hl(0, "@function.method", { fg = colors.func, bold = true })
        vim.api.nvim_set_hl(0, "@function.builtin", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@function.call", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@function.method.call", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@variable", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@variable.builtin", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@variable.builtin.python", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@variable.parameter", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@variable.member", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@module", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@property", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@lsp.type.comment", { fg = colors.comment })
        vim.api.nvim_set_hl(0, "@lsp.type.string", { fg = colors.string })
        vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@lsp.type.module", { fg = colors.fg })
        vim.api.nvim_set_hl(0, "@lsp.typemod.function.declaration", { fg = colors.func, bold = true })
        vim.api.nvim_set_hl(0, "@lsp.typemod.function.definition", { fg = colors.func, bold = true })
        vim.api.nvim_set_hl(0, "@lsp.typemod.method.declaration", { fg = colors.func, bold = true })
        vim.api.nvim_set_hl(0, "@lsp.typemod.method.definition", { fg = colors.func, bold = true })
        vim.api.nvim_set_hl(0, "Search", { fg = colors.bg, bg = colors.fg })
        vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.bg, bg = colors.primary })
        vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg, bg = "#0a0008" })
        vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.bg, bg = colors.fg })
        vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = "#0a0008" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.muted, bg = "#0a0008" })
        vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.muted })
        vim.api.nvim_set_hl(0, "Title", { fg = colors.warning, bold = true })
        vim.api.nvim_set_hl(0, "ErrorMsg", { fg = colors.light, bg = colors.danger, bold = true })
        vim.api.nvim_set_hl(0, "WarningMsg", { fg = colors.bg, bg = colors.warning })
        vim.api.nvim_set_hl(0, "MoreMsg", { fg = colors.success })
        vim.api.nvim_set_hl(0, "ModeMsg", { fg = colors.fg, bold = true })

        -- Diff highlighting
        vim.api.nvim_set_hl(0, "DiffAdd", { fg = colors.success, bg = "#001a00" })
        vim.api.nvim_set_hl(0, "DiffChange", { fg = colors.warning, bg = "#1a1a00" })
        vim.api.nvim_set_hl(0, "DiffDelete", { fg = colors.danger, bg = "#1a001a" })
        vim.api.nvim_set_hl(0, "DiffText", { fg = colors.fg, bg = "#2a2a00", bold = true })

        -- Git signs
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.success })
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.warning })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.danger })

        -- Diagnostic
        vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.danger })
        vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.warning })
        vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.secondary })
        vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.info })
      end,
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = function(_, opts)
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#ef0000" })
      return opts
    end,
  },
}
