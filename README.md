# edu-bspwm

Educational / tutorial repository for [bspwm](https://github.com/baskerville/bspwm), a tiling window manager that represents windows as the leaves of a binary tree. Part of the `~/EDU/` learning series — a working bspwm config dropped on top of a fresh Arch / Kiro install.

## What's in this repo

- `etc/skel/` — user-facing configs (bspwm + sxhkd keybindings) that land in `/etc/skel/` and propagate to new users.
- `setup.sh`, `up.sh`, `cleanup.sh` — standard EDU bash scaffold.

## Installation

### From `nemesis_repo` (recommended)

```ini
[nemesis_repo]
SigLevel = Never
Server = https://erikdubois.github.io/$repo/$arch
```

```bash
sudo pacman -Syu
sudo pacman -S edu-bspwm
```

You'll also need bspwm + sxhkd:

```bash
sudo pacman -S bspwm sxhkd
```

### Manual

```bash
git clone https://github.com/erikdubois/edu-bspwm.git
cd edu-bspwm
sudo cp -r etc/skel/. /etc/skel/
```

Existing users can pull the config into their own home:

```bash
cp -rT /etc/skel ~/
```

## Websites

Information : https://erikdubois.be

## Social Media

Youtube : https://www.youtube.com/erikdubois

## License

See [LICENSE](./LICENSE).
