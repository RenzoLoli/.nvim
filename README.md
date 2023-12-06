# zorc

- My own vim config

## !todo
    
    -- core:

        * utils
        * bootstrap
        * mappings
        * variables
        * error / log

    -- plugins:

        ** Package Manager

        * lazy:             folke/lazy.nvim
        
        ** Telescope

        * telescope:        nvim-telescope/telescope.nvim
        * telescope-import: piersolenski/telescope-import.nvim

        ** LSP

        * nvim-lspconfig:   neovim/nvim-lspconfig 
        * nvim-lsp:         hrsh7th/nvim-lsp
        * cmp-buffer:       hrsh7th/cmp-buffer
        * cmp-nvim-lsp:     hrsh7th/cmp-nvim-lsp
        * lspkind:          onsails/lspkind.nvim
        * nvim-lint:        mfussenegger/nvim-lint
        * formatter:        mhartington/formatter.nvim

        ** Complements

        * lualine:          nvim-lualine/lualine.nvim
        * markdown-preview: iamcco/markdown-preview.nvim
        * vim-startuptime:  dstein64/vim-startuptime

        ** Themes

        * monokai-pro:     loctvl842/monokai-pro.nvim
        * gruvbox:         ellisonleao/gruvbox.nvim
        * sonokai:         sainnhe/sonokai
        * tokionight:      folke/tokyonight.nvim

    -- language-servers:

        * c/c++:            

            - server:       clangd
            - formatter:    clang-format
            - linter:       clang-tidy

        * python:           
            
            - server:       pyright
            - formatter:    black 
            - linter:       flake8 / ruff

        * lua:              

            - server:       lua-language-server
            - formatter:    stylua
            - linter:       luacheck

        * rust:             

            - server:       rust-analyzer
            - formatter:    rustfmt
            - linter:       _

        * javascript / typescript:

            - server:       tsserver
            - formatter:    clang-format / prettierd    
            - linter:       eslint_d

        * html:

            - server:       html
            - formatter:    prettierd
            - linter:       tidy

        * css: 

            - server:       cssls
            - formatter:    prettierd
            - linter:       stylelint

        * angular:          

            - server:       angularls
            - formatter:    _
            - linter:       eslint_d

        * react:            

            - server:       tsserver
            - formatter:    stylua
            - linter:       luacheck

        * markdown:         

            - server:       marksman
            - formatter:    prettierd
            - linter:       vale

        * zsh:

            - server:       bashls
            - formatter:    beautysh
            - linter:       zsh

        * cmake:

            - cmake:        cmake
            - formatter:    cmakeformat
            - linter:       cmakelint


