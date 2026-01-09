local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local make_entry = require("telescope.make_entry")
local sorters = require("telescope.sorters")
local utils = require("telescope.utils")
local actions = require("telescope.actions")

local flatten = vim.tbl_flatten

local function has_rg_program(name, program)
  if vim.fn.executable(program) == 1 then
    return true
  end
  vim.notify(name .. " requires ripgrep (rg)", vim.log.levels.ERROR)
  return false
end

local M = {}

M.live_grep_ext = function(opts)
  opts = opts or {}

  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  if not has_rg_program("live_grep_ext", vimgrep_arguments[1]) then
    return
  end

  opts.cwd = opts.cwd and utils.path_expand(opts.cwd) or vim.loop.cwd()

  local args = flatten({ vimgrep_arguments })

  local live_grepper = finders.new_job(function(prompt)
    if type(prompt) ~= "string" or prompt == "" then
      return nil
    end

    local text, ext = prompt:match("^(.-)%s%s(%S+)$")

    local final_prompt = prompt
    local final_args = args

    if text and ext and not text:match("%s$") then
      final_prompt = text
      final_args = vim.list_extend(vim.deepcopy(args), {
        "--glob",
        "*." .. ext,
      })
    end

    return flatten({
      final_args,
      "--",
      final_prompt,
    })
  end, make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

  pickers
    .new(opts, {
      prompt_title = "Live Grep (text␠␠ext)",
      finder = live_grepper,
      previewer = conf.grep_previewer(opts),
      sorter = sorters.get_generic_fuzzy_sorter(opts),

      attach_mappings = function(_, map)
        map("i", "<Up>", actions.cycle_history_prev)
        map("i", "<C-p>", actions.cycle_history_prev)
        map("i", "<Down>", actions.cycle_history_next)
        map("i", "<C-n>", actions.cycle_history_next)
        return true
      end,
    })
    :find()
end

return M
