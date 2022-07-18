return {
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "self",
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			procMacro = {
				enable = true,
			},
			-- enable clippy on save
			checkOnSave = {
				command = "clippy",
			},
			inlayHints = {
				typeHints = {
					enable = true,
				},
				bindingModeHints = {
					enable = true,
				},
			},
		},
	},
}
