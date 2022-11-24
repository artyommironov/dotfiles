# Install

```
git clone --bare git@github.com:artyommironov/dotfiles.git ~/.homegit
git --git-dir=$HOME/.homegit --work-tree=$HOME checkout -f
echo '*' >> ~/.homegit/info/exclude
```

