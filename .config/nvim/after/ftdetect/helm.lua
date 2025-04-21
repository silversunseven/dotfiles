vim.filetype.add({
  pattern = {
    [".*/templates/.*%.yaml"] = "helm",
    [".*/templates/.*%.txt"] = "helm",
    [".*/templates/.*%.tpl"] = "helm",
  },
})
