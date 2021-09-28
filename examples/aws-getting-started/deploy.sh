#!/bin/env

if terraform apply -auto-approve; then
    echo "Deployed succesfully"
else
    echo "Initiating Terraform apply round #2. This is expected behavior due to timing issues on the AWS backend."
    terraform apply -auto-approve
fi

exit 0
