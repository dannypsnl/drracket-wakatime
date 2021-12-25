# drracket-wakatime

[![Racket Test](https://github.com/racket-tw/drracket-wakatime/actions/workflows/racket-gui-test.yml/badge.svg)](https://github.com/racket-tw/drracket-wakatime/actions/workflows/racket-gui-test.yml)
[![Coverage Status](https://coveralls.io/repos/github/racket-tw/drracket-wakatime/badge.svg?branch=develop)](https://coveralls.io/github/racket-tw/drracket-wakatime?branch=develop)

Install `wakatime-cli` is required for the plugin, you can get it via

```shell
brew install wakatime-cli # macOS
nix-env -iA nixpkgs.wakatime # Linux
```

You would need to enter your API key when first time use this plugin, you can get it from [wakatime account setting](https://wakatime.com/settings/account), by copy **Secret API Key**. Once this all done, you should be able to see your wakatime report on your [wakatime dashboard](https://wakatime.com/dashboard)!

### reference

1. [vim implementation](https://github.com/wakatime/vim-wakatime/blob/master/plugin/wakatime.vim#L471)
