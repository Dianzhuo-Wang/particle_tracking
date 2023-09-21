for f in /n/scratch3/users/y/ys258/20210825/*.tif;
do echo ${f##*/};
./track ${f##*/};
done

