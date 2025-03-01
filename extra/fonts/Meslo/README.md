
# MesloLGS Nerd Font

- [(Source) MesloLGS Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo/S)

<!-- Original GitHub:
https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Meslo/S/Regular/MesloLGSNerdFont-Regular.ttf
https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Meslo/S/Italic/MesloLGSNerdFont-Italic.ttf
https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Meslo/S/Bold/MesloLGSNerdFont-Bold.ttf
https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Meslo/S/Bold-Italic/MesloLGSNerdFont-BoldItalic.ttf
-->

  > Download Links (from this repository):
  >
  > - [MesloLGS Nerd Font Regular.ttf](https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Regular.ttf)
  > - [MesloLGS Nerd Font Bold.ttf](https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Bold.ttf)
  > - [MesloLGS Nerd Font Italic.ttf](https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Italic.ttf)
  > - [MesloLGS Nerd Font Bold Italic.ttf](https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-BoldItalic.ttf)

## CSS

### CSS style sheet URL

```bash
https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/meslo.css
```

```css
@font-face {
    font-family: "MesloLGS Nerd Font";
    font-style: normal;
    font-weight: normal;
    src: url("https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Regular.ttf")
        format("truetype");
}

@font-face {
    font-family: "MesloLGS Nerd Font";
    font-style: italic;
    font-weight: normal;
    src: url("https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Italic.ttf")
        format("truetype");
}

@font-face {
    font-family: "MesloLGS Nerd Font";
    font-style: normal;
    font-weight: bold;
    src: url("https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Bold.ttf")
        format("truetype");
}

@font-face {
    font-family: "MesloLGS Nerd Font";
    font-style: italic;
    font-weight: bold;
    src: url("https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-BoldItalic.ttf")
        format("truetype");
}
```

## MacOS

### (Case 1) Using Homebrew

> This installs all of the Meslo Nerd Font variants.  
> You may want to remove the unnecessary font files.  
> e.g., Meslo LG L, Meslo LG M, Windows-Compatible, Propo, etc.

```bash
brew install font-meslo-lg-nerd-font
```

### (Case 2) Download each font file directly to `~/Library/Fonts/`

```bash
# Downloading the Font Files
$ curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Regular.ttf -o ~/Library/Fonts/MesloLGSNerdFont-Regular.ttf
$ curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Bold.ttf -o ~/Library/Fonts/MesloLGSNerdFont-Bold.ttf
$ curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Italic.ttf -o ~/Library/Fonts/MesloLGSNerdFont-Italic.ttf
$ curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-BoldItalic.ttf -o ~/Library/Fonts/MesloLGSNerdFont-BoldItalic.ttf

# Verifying the Installation
$ open ~/Library/Fonts/
```

## Linux

### Download each font file directly to `~/.local/share/fonts/`

```bash
# Downloading the Font Files
$ curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Regular.ttf -o ~/.local/share/fonts/Meslo/MesloLGSNerdFont-Regular.ttf
$ curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Bold.ttf -o ~/.local/share/fonts/Meslo/MesloLGSNerdFont-Bold.ttf
$ curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-Italic.ttf -o ~/.local/share/fonts/Meslo/MesloLGSNerdFont-Italic.ttf
$ curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/extra/fonts/Meslo/MesloLGSNerdFont-BoldItalic.ttf -o ~/.local/share/fonts/Meslo/MesloLGSNerdFont-BoldItalic.ttf

# Updating the Font Cache
$ fc-cache -f -v

# Verifying the Installation
$ fc-list | grep "MesloLGS Nerd Font"
```
