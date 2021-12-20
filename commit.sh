cd lib/widgets
for file in *
do
  git add $file
  git commit -m $1
done

cd -

cd lib/utils
for file in *
do
  git add $file
  git commit -m $1
done


cd -

cd lib/extensions
for file in *
do
  git add $file
  git commit -m $1
done


cd -

cd lib/screens
for file in *
do
  git add $file
  git commit -m $1
done

cd -
git add main.dart
git commit -m $1