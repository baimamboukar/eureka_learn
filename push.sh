for file in $(git ls-files --others --modified --exclude-standard); do
    git add $file
    git commit -m "[$1] $2 🚀"
done
git push