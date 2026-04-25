-- agentic.nvim — ACP-based chat for Claude Code (and other ACP providers)
-- Requires: npm i -g @agentclientprotocol/claude-agent-acp (handled in install.sh)
return {
	"carlos-algms/agentic.nvim",
	event = "VeryLazy",
	opts = {
		provider = "claude-agent-acp",
		acp_providers = {
			["claude-agent-acp"] = {
				env = {
					ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
				},
			},
		},
	},
	keys = {
		{
			"<C-\\>",
			function() require("agentic").toggle() end,
			mode = { "n", "v", "i" },
			desc = "Toggle Agentic chat",
		},
		{
			"<leader>aa",
			function() require("agentic").toggle() end,
			mode = { "n", "v" },
			desc = "Toggle Agentic chat",
		},
		{
			"<leader>an",
			function() require("agentic").new_session() end,
			desc = "New Agentic session",
		},
		{
			"<leader>ar",
			function() require("agentic").restore_session() end,
			desc = "Restore Agentic session (incl. terminal claude sessions)",
		},
	},
}
