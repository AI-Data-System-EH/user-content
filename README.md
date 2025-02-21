# user-content

## Base URL

```bash
https://raw.githubusercontent.com/AI-Data-system-EH/user-content/<branch>/<content_path>
```

## Usage

```bash
curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/<branch>/<content_path> -o <destination_path>
```

> **Note:** Replace `<branch>` with the branch name and `<content_path>` with the path of the content.
>
> - f : Fail silently (no output at all) on HTTP errors (H)
> - s : Silent mode (don't output anything)
> - S : Show error. With -s, make curl show errors when they occur
> - L : Follow redirects
> - o : Write output to file instead of stdout

## .zshrc

```bash
curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/.zshrc -o ~/.zshrc
```

## .p10k.zsh

```bash
curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/.p10k.zsh -o ~/.p10k.zsh
```
