-- claudecode.nvim — nvim acts as IDE server; Claude CLI connects via WebSocket
-- Workflow: run `claude` in a tmux pane (or <leader>ac to toggle terminal in nvim);
-- claude auto-discovers nvim through the lock file and gains access to selection,
-- file context, and diff approval.
return {
	"coder/claudecode.nvim",
	cmd = {
		"ClaudeCode",
		"ClaudeCodeFocus",
		"ClaudeCodeSelectModel",
		"ClaudeCodeSend",
		"ClaudeCodeAdd",
		"ClaudeCodeDiffAccept",
		"ClaudeCodeDiffDeny",
	},
	opts = {
		terminal = {
			provider = "native", -- built-in nvim terminal, avoids snacks.nvim dep
		},
	},
	keys = {
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to Claude" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
	},
}
