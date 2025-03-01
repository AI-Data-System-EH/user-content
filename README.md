# user-content

_This repository contains static user content such as configuration files, install scripts, fonts and more._

<br/>

## :gem: Base URL

`https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/<content_path>`

### Usage

`curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/<content_path> -o <destination_path>`

## :coffee: ZSH

### .zshrc (Oh My Zsh)

```bash
curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/.zshrc -o ~/.zshrc
```

### .p10k.zsh (Powerlevel10k)

```bash
curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/.p10k.zsh -o ~/.p10k.zsh
```

## :cake: Fonts

### [Meslo](./extra/fonts/Meslo/README.md)

```bash
# CSS style sheet URL
https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/meslo.css
```

## :cookie: Extra

### motd (Message of the Day)

```bash
sudo curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/motd -o /etc/motd
```
