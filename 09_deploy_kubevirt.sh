#!/bin/bash

set -ex

eval "$(go env)"
echo "$GOPATH" | lolcat # should print $HOME/go or something like that

export HCOKUBEVIRTPATH="$GOPATH/src/github.com/kubevirt/hyperconverged-cluster-operator"
export KUBECONFIG=~/dev-scripts/ocp/auth/kubeconfig

# create new project kubevirt-hyperconverged
oc new-project kubevirt-hyperconverged
oc project kubevirt-hyperconverged

cd $HCOKUBEVIRTPATH

# create hyperconverged crds
oc create -f deploy/converged/crds/hco.crd.yaml
oc create -f deploy/converged/crds/kubevirt.crd.yaml
oc create -f deploy/converged/crds/cdi.crd.yaml
oc create -f deploy/converged/crds/cna.crd.yaml
oc create -f deploy/converged/crds/ssp.crd.yaml
oc create -f deploy/converged/crds/kwebui.crd.yaml
oc create -f deploy/converged/crds/nodemaintenance.crd.yaml

# Create Service Accounts, Cluster Role(Binding)s, and Operators.
oc create -f deploy/converged

# Create an HCO CustomResource
oc create -f deploy/converged/crds/hco.cr.yaml




