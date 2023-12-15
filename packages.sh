for arg in "$*"; do
    echo $arg
    helm package $arg
    mv $arg-*.tgz ../chartrepo
    cd ../chartrepo
    helm repo index --url https://no8ge.github.io/chartrepo/ .
    git add .
    git commit -m 'update'
    git push
done
