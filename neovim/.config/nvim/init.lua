local present, impatient = pcall(require, "impatient")
if present then
	impatient.enable_profile()
end

require("nvim")
require("option")
require("autocmd")
require("plugins")
