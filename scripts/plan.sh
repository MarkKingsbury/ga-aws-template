#!/bin/bash
set -e


echo
function cleanup {
    status=$?;
    if [ $status != 0 ] && [ -f error.txt ]; then echo "Failure: $status" && python3 ../scripts/send_to_cw.py error.txt; fi
}

trap cleanup EXIT

pwd
ls -la
cd "${TF_DIR}"
pwd
ls -la
sh ../scripts/init.sh
terraform plan -input=false -out plan.out > /dev/null 2> error.txt
aws s3 cp plan.out "${TERRAFORM_PLAN_BUCKET}"/"${ENV}"/"${TRIGGERING_ACTOR}"/ > /dev/null 2> error.txt