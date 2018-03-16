#!/bin/bash
source ~/Projects/biobank/biobank/bin/activate
model=linear
nloci=5000
for g in $(seq 1 10); do
    i=g$g
    k=10000
    time python main.py --id $i$model$nloci --genmodel $model --loci $nloci --k $k --method lasso --shape 10 --recreation True
    for k in 20000 50000; do
        python main.py --id $i$model$nloci --genmodel $model --loci $nloci --k $k --shape 10 --method lasso
    done
    for k in 10000 20000 50000; do
        for method in ridge mlp1 mlp2; do
            python main.py  --id $i$model$nloci --genmodel $model --loci $nloci --k $k --shape 10 --method $method 
        done
    done
done