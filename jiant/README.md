This directory contains code and data release for the following paper:

[Nan-Jiang Jiang, Marie-Catherine de Marneffe. Investigating Reasons for Disagreement in Natural Language Inference TACL 2022](https://arxiv.org/abs/2209.03392)

### Getting started

First, follow the [tutorial](tutorials/setup_tutorial.md) to install dependencies and set up environments.

To train a 4-way classifier, do
```
./train_4way.sh chaos_orig 0
```

To train a multilabel classifier, do
```
./train_4way.sh chaos_orig_multilabel 0
```


### Data
The directory [glue_data](glue_data) contains the preprocessed data and splits used in the paper.

 
### License

This package is based on [jiant v1](https://github.com/nyu-mll/jiant-v1-legacy).
`jiant` is released under the [MIT License](LICENSE.md). The material in the allennlp_mods directory is based on [AllenNLP](https://github.com/allenai/allennlp), which was originally released under the Apache 2.0 license.