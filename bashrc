# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

for file in ~/.bashrc.d/*;
do
    source "$file"
done
