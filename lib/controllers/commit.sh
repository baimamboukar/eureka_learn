for file in *
do
  echo $file
  git add $file
  git commit -m $1
  git push
done