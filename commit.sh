cd lib/controllers
for file in *
do
  git add $file
  git commit -m $1
  git push
done


cd -
cd lib/enum
for file in *
do
  git add $file
  git commit -m $1
  git push
done
git push

cd -
cd lib/models
for file in *
do
  git add $file
  git commit -m $1
done
git push

cd -
cd lib/providers
for file in *
do
  git add $file
  git commit -m $1
  git push
done
git push

cd -
cd lib/screens
for file in *
do
  git add $file
  git commit -m $1
done
git push

cd -
cd lib/services
for file in *
do
  git add $file
  git commit -m $1
done
git push

cd -
cd lib/utils
for file in *
do
  git add $file
  git commit -m $1
  git push
done
git push

cd -
cd lib/widgets
for file in *
do
  git add $file
  git commit -m $1
  git push
done
git push


