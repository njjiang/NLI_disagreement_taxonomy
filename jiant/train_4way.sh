task=$1
seed=${2:-0}

set -e
OVERRIDES="exp_name = EXP_4way"
OVERRIDES+=", run_name = \"${task}--${seed}\""
OVERRIDES+=", pretrain_tasks = \"$task\""
OVERRIDES+=", target_tasks = \"$task\""
OVERRIDES+=", do_pretrain = 0"
OVERRIDES+=", random_seed=$seed"
OVERRIDES+=", do_target_task_training = 1"
OVERRIDES+=", do_full_eval = 1"
OVERRIDES+=", cuda = auto"
OVERRIDES+=", batch_size = 4"
OVERRIDES+=", input_module=roberta-large"
OVERRIDES+=", lr = 0.0000100"
OVERRIDES+=", sent_enc=none, sep_embs_for_skip=1, transfer_paradigm=finetune, write_preds=\"val,test\"" # no phrase layers

pushd "${PWD%jiant*}jiant"

echo $OVERRIDES
python main.py -c jiant/config/defaults.conf chaos.conf -o "${OVERRIDES}"


OVERRIDES+=", target_tasks = \"MNLI_matched,MNLI_mismatched\""
OVERRIDES+=", do_pretrain = 0"
OVERRIDES+=", do_target_task_training = 0"
OVERRIDES+=", do_full_eval = 1"
OVERRIDES+=", use_classifier=$task"
OVERRIDES+=", write_strict_glue_format = 0"
OVERRIDES+=", write_preds = \"val\""

echo $OVERRIDES
python main.py -c jiant/config/defaults.conf chaos.conf -o "${OVERRIDES}"
