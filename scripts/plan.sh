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
echo "get parameters"
aws ssm get-parameters --name "${AWS_PARAM_STORE_TF_VARS_KEY}" --with-decryption --query "Parameters[*].Value" --output text > terraform.tfvars.json 2> error.txt
ls -la
terraform plan -var-file="terraform.tfvars.json" -input=false -out plan.out > /dev/null 2> error.txt
terraform show -no-color plan.out > plan.txt
python3 ../scripts/send_to_cw.py plan.txt
aws s3 cp plan.out "${TERRAFORM_PLAN_BUCKET}"/"${ENV}"/"${TRIGGERING_ACTOR}"/ > /dev/null 2> error.txt