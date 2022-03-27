local ls = require"luasnip"
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
        local lst = vim.split(text, '.', {plain = true})
        local suggestion = lst[#lst]
        return sn(nil, {i(1, suggestion)})
end


local function ni()
        return t{"", "\t"}
end

local function newline()
        return t{"", ""}
end

local function indent(text)
        return t("\t".. text)
end

local function inline_comment(text)
        local cmt = vim.bo.commentstring:gsub(" %%s", "")
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

local snippets = {
        all = {
                -- Todo snippet
                s("todo", fmt( [[{} TODO: {} ]], { cmt(), i(0) } ));
                -- Header for a file
                s("header", fmt([[
                {} File:   {} 
                {} Author: {} <{}> 
                {} Description:
                {}      {}
                ]], { 
                        cmt(), f(function (_) return filename() end),
                        cmt(), f(function (_) return vim.g.my_name end), f(function (_) return vim.g.my_email end),
                        cmt(), cmt(), i(0)
        }));
        };
        lua = {
                -- Snippet to make a new snippet
                s("snip", fmt("s(\"{}\", fmt([[{}]], {{ {} }} ));", {i(1), i(2), i(3)})),
                -- require snippet, gives nice suggestion for variable name
                s("req", fmt( [[ local {} = require("{}")]], { d(2, require_local_name, {1}), i(1) } ));
                -- General function snippet
                s("fun", fmt([[local function {}({}){}{}{}end]], {
                        i(1, "foo"),
                        i(2, "args"),
                        ni(),
                        i(0),
                        newline(),
                } ));
        };
        go = {
                -- 'if err != nil' snippet
                s("eif", fmt([[if {} != nil {{{}{}{}}}{}{}]], {
                        i(1, "err"),
                        ni(),
                        i(2, "return nil"),
                        newline(),
                        newline(),
                        i(0)
                } ));
        };
}

ls.snippets = snippets

M = {}

function M.init_snippets()
        ls.snippets = snippets
end

return M
