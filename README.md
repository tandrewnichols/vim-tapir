# Vim-Tapir

            _,.,.__,--.__,-----.
         ,""   '))              `.
       ,'   e                    ))
      (  .='__,                  ,
       `~`     `-\  /._____,/   /
                | | )    (  (   ;
                | | |    / / / / 
        vvVVvvVvVVVvvVVVvvVVvVvvvVvPhSv 

A REST client for vim

## Overview

Work in progress. This is completely unstable . . . like _alpha_ alpha. Install at your own peril. It does actually do a few things _now_ though. You can make GET, POST, PUT, etc. requests in the current window (e.g.` EGet`), a new split (e.g. `SPost`), a new vertical split (e.g. `VPut`), or a new tab (e.g. `TPatch`). The response text will be populated in that buffer (and syntax highlighted/formatted if it's html or json), and the headers will be opened above it. The `Get` family is the only really useful thing right, as I haven't added support for a post body in POST/PUT, so you can't actually send data at the moment. You may want to use `:bw` or `:bd` instead of `:q` when closing out these buffers, otherwise you get errors the next time your run a command.

## Installation

If you don't have a preferred installation method, I really like vim-plug and recommend it.

#### Manual

Clone this repository and copy the files in plugin/, autoload/, and doc/ to their respective directories in your vimfiles, or copy the text from the github repository into new files in those directories. Make sure to run `:helptags`.

#### Plug (https://github.com/junegunn/vim-plug)

Add the following to your vimrc, or something sourced therein:

```vim
Plug 'tandrewnichols/vim-tapir'
```

Then install via `:PlugInstall`

#### Vundle (https://github.com/gmarik/Vundle.vim)

Add the following to your vimrc, or something sourced therein:

```vim
Plugin 'tandrewnichols/vim-tapir'
```

Then install via `:BundleInstall`

#### NeoBundle (https://github.com/Shougo/neobundle.vim)

Add the following to your vimrc, or something sourced therein:

```vim
NeoBundle 'tandrewnichols/vim-tapir'
```

Then install via `:BundleInstall`

#### Pathogen (https://github.com/tpope/vim-pathogen)

```sh
git clone https://github.com/tandrewnichols/vim-tapir.git ~/.vim/bundle/vim-tapir
```

## Usage

Coming soon.

## Contributing

I always try to be open to suggestions, but I do still have opinions about what this should and should not be so . . . it never hurts to ask before investing a lot of time on a patch.

## License

See [LICENSE](./LICENSE)
