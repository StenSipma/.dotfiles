local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt

-- Function to be used with a dynamic node which takes the first line of the
-- first argument, splits it based on a '.' and returns an insert node based on
-- the last entry in the split
local function require_local_name(args, _)
    local text = args[1][1] or ""
    local lst = vim.split(text, '.', { plain = true })
    local suggestion = lst[#lst]
    return sn(nil, { i(1, suggestion) })
end


local function ni()
    return t { "", "\t" }
end

local function newline()
    return t { "", "" }
end

local function indent(text)
    return t("\t" .. text)
end

local function inline_comment(text)
    -- Remove the '%s' from the commentstring:
    local cmt = vim.bo.commentstring:gsub(" ?%%s", "")
    return cmt .. text
end

local function cmt()
    return f(function(_) return inline_comment("") end, {})
end

local function filename()
    local full_name = vim.api.nvim_buf_get_name(0)
    local splits = vim.split(full_name, "/")
    return splits[#splits]
end

local function python_docstring(args, _)
    local func_name = args[1][1] or ""
    local arguments = args[2][1] or ""
    -- TODO: Make better =D
    -- 1. Split the arguments
    -- 2. format the docstring based on arguments
    -- 3. maybe make it a choice node to show docstring or not.
    return [["""]] .. arguments .. [["""]]
end

M = {}

function M.load_snipmate(path)
    local sm = require('luasnip.loaders.from_snipmate')
    sm.load({ path = path })
    ls.filetype_extend('all', { '_' })
end

function M.init_snippets()
    ls.add_snippets("all", {
        -- Todo snippet
        s("todo", fmt([[{} TODO: {} ]], { cmt(), i(0) })),
        -- Header for a file
        s("header", fmt([[
                {} File:   {}
                {} Author: {} <{}>
                {} Description:
                {}      {}
                ]], {
            cmt(), f(function(_) return filename() end),
            cmt(), f(function(_) return vim.g.my_name end), f(function(_) return vim.g.my_email end),
            cmt(), cmt(), i(0)
        })),
    })

    ls.add_snippets("lua", {
        -- Snippet to make a new snippet
        s("snip", fmt("s(\"{}\", fmt([[{}]], {{ {} }} ));", { i(1), i(2), i(3) })),
        -- require snippet, gives nice suggestion for variable name
        s("req", fmt([[ local {} = require("{}")]], { d(2, require_local_name, { 1 }), i(1) })),
        -- General function snippet
        s("fun", fmt([[local function {}({}){}{}{}end]], {
            i(1, "foo"),
            i(2, "args"),
            ni(),
            i(0),
            newline(),
        })),
    })

    ls.add_snippets("python", {
        s("fun", fmt([[
                def {}({}):
                    {}
                    {}
                ]], {
            i(1, "foo"),
            i(2, "args"),
            f(python_docstring, { 1, 2 }),
            i(0),
        })),
        s("ifm", fmt([[
                if __name__ == '__main__':
                    {}{}
                ]], { i(1, "main()"), i(0) })),
        s("np", fmt([[
                import numpy as np
                {}
                ]], { i(0) })),
        s("plt", fmt([[
                import matplotlib.pyplot as plt
                {}
                ]], { i(0) })),
        s("pd", fmt([[
                import pandas as pd
                {}
                ]], { i(0) })),
    })

    ls.add_snippets("go", {
        -- 'if err != nil' snippet
        s("eif", fmt([[
                        if {} != nil {{
                                {}
                        }}
                        {}
                        ]], {
            i(1, "err"),
            i(2, "return nil"),
            i(0)
        })),
    })

    ls.add_snippets("tex", {
        -- Math align environment
        s("alis", fmt([[
                        \begin{{align*}}
                                {} &= {} \\
                        \end{{align*}}]], {
            i(1, "f(x)"),
            i(0)
        })),

        -- Custom preamble loader
        s("pream", fmt([[\input{{/home/sten/Documents/Study/homework_template/preamble.tex}}]], {})),

        -- Bibtex setup
        s("bib", fmt([[
                        \usepackage{{biblatex}}
                        \addbibresource{{bibtex.bib}}
                        ]], {}
        )),

        -- Simple LaTeX skeleton
        s("skeleton", fmt([[
                        \documentclass[12pt]{{article}}

                        \usepackage[a4paper,margin=1.8cm]{{geometry}} % Reduce the margin on all sides of the paper
                        \usepackage{{float}}                          % Flexibility for image placement

                        \title{{}}
                        \author{{}}
                        \date{{\today}}

                        \begin{{document}}
                        \maketitle

                        {}
                        \end{{document}}
                ]], { i(0) })),

        s("ac", fmt([[\ac{{{}}} {}]], { i(1), i(0) })),

        s("declareac", fmt([[
                        \DeclareAcronym{{{}}}{{
                                short={},
                                long={},
                        }}
                        {}
                ]], { i(1), i(2), i(3), i(0) })),

        -- IDEA: change capitalization of si, based on number of
        -- arguments given (i.e. si when only unit, SI when also number
        -- is given)
        s("si", fmt([[\SI{{{}}}{{{}}} {}]], { i(1), i(2), i(0) })),

        -- Quick text styles
        s("it", fmt([[\textit{{{}}} {}]], { i(1), i(0) })),
        s("bf", fmt([[\textbf{{{}}} {}]], { i(1), i(0) })),
        s("tt", fmt([[\texttt{{{}}} {}]], { i(1), i(0) })),
        s("rm", fmt([[\textrm{{{}}} {}]], { i(1), i(0) })),
        s("txt", fmt([[\text{{{}}} {}]], { i(1), i(0) })),

        -- Math
        s("frac", fmt([[\frac{{{}}}{{{}}} {}]], { i(1), i(2), i(0) })),
    })
end

-- Also init snippets on file load
-- M.init_snippets()

return M
