git add . 
git commit -m "$1"
git tag $1
git push origin $1
git push
