#!/bin/bash

/share/apps/singularity/bin/singularity \
    exec --nv --bind /raid \
    /share/apps/public/singularity/centos-7.6.1810.sif \
    bash -c "export CUDA_VISIBLE_DEVICES=1,2,3,0,4,7,6,5; export PATH=.:/home/dm4511/anaconda3/bin:$PATH; bash pre-train-roberta.sh data-bin/combined first-combined 50 > t1.log 2>&1"




