task=$1
seed=${2:-0}
lr=${3:-5e-6}

if [[ $1 == "" ]]; then
    echo "need to provide a task argument"
    exit 1
fi

set -e
OVERRIDES="exp_name = EXP_multilabel"
OVERRIDES+=", run_name = \"$task--${seed}\""
OVERRIDES+=", pretrain_tasks = \"$task\""
OVERRIDES+=", target_tasks = \"$task\""
OVERRIDES+=", do_pretrain = 0"
OVERRIDES+=", random_seed=$seed"
OVERRIDES+=", do_target_task_training = 1"
OVERRIDES+=", do_full_eval = 1"
OVERRIDES+=", lr = $lr"
OVERRIDES+=", delete_checkpoints_when_done=0"

pushd "${PWD%jiant*}jiant"

echo $OVERRIDES
python main.py -c jiant/config/defaults.conf multilabel.conf chaos.conf -o "${OVERRIDES}"

OVERRIDES+=", target_tasks = \"MNLI_matched_multilabel,MNLI_mismatched_multilabel\""
OVERRIDES+=", do_pretrain = 0"
OVERRIDES+=", do_target_task_training = 0"
OVERRIDES+=", do_full_eval = 1"
OVERRIDES+=", use_classifier=$task"
OVERRIDES+=", write_strict_glue_format = 0"
OVERRIDES+=", write_preds = \"val\""

if [[ $seed -gt 0 ]]
then
    OVERRIDES+=", delete_checkpoints_when_done=1"
fi


echo $OVERRIDES
python main.py -c jiant/config/defaults.conf multilabel.conf chaos.conf -o "${OVERRIDES}"
