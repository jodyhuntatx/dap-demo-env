# dap-demo-env

General demo environment for DAP showing various tool and platform integrations.

## Configuration files - review and edit first
azure.config
 - ./config/dap.config - master config file
dockerdesktop.docker
dockerdesktop.k8s
minikube.k8s
minishift.docker
minishift.env
minishift.k8s
 - ./config/openshift.config - config for OCP env
 - ./config/kubernetes.config - config for K8s env
 - ./config/utils.sh - utility bash functions, does not need editing

## Management scripts
 - ./bin/demoshell/ - directory for building demoshell container
 - ./bin/get_cert_REST.sh
 - ./bin/install_dependencies.sh - installs minikube, minishift, etc. on host 
 - ./bin/k8s-minikube-start.sh - start, stops & reinitialized minikube env
 - ./bin/k8s_registry_list.sh
 - ./bin/k8sdashboard.yaml
 - ./bin/list_all_REST.sh
 - ./bin/load_policy_REST.sh - script that loads DAP policy w/ REST call
 - ./bin/oc-minishift-start.sh - start, stops & reinitialized minishift env
 - ./bin/start_stop_all.sh - starts up demos once minishift/kube are running
 - ./bin/strt_k8sdash.sh - starts k8s dashboard for docker desktop k8s
 - ./bin/stp_k8sdash.sh - stops k8s dashboard for docker desktop k8s
 - ./bin/k8sdashboard.yaml - yaml for k8s dashboard for docker desktop k8s
 - ./bin/resource_permitted_roles_CLI.sh
 - ./bin/rotate_api_key_CLI.sh
 - ./bin/scope_launch.sh
 - ./bin/start_stop_all.sh
 - ./bin/stp_k8sdash.sh
 - ./bin/strt_k8sdash.sh
 - ./bin/var_get_set_REST.sh
 - ./bin/var_value_add_REST.sh - script that sets DAP variable w/ REST call
 - ./bin/var_value_get_REST.sh
 - ./bin/verify_k8s_api_access.sh

## Demo directories
 - 0_load_images
 - 1_master_cluster - starts master & cli in minishift/kube docker daemon
 - 2_epv_synchronizer - initializes new DAP master for synchronizer
 - 3_target_systems
 - AIMCCP_demo - playbook that formats a REST call to CCP
 - AWS_authn_demo - demos for authn-iam (AWS-hosted master)
 - AZURE_demo - demos for authn-azure (Azure-hosted master)
 - CICD_demos - general Summon demo w/ chef, ansible & terraform integration demos
 - JAVA_demo - simple java client that pulls a secret
 - JENKINS_demo - Jenkins plugin demo
 - K8S_apps_demo - Demo app in k8s or Openshift (works for both)
 - K8S_followers - Follower installation in k8s or Openshift (works for both)
 - K8S_injector_demo - Webhook sidecar injector for k8s
 - K8S_secretless_demo - Secretless demo app in k8s or Openshift (works for both)
 - PKIaaS_demo - mutual TLS authentication using self-signed CA
 - POLICY_example - example policies showing best practices
 - PSMP_demo - scripts that use psmp to login to AWS or Azure VMs
 - PUPPET_demo - builds Puppet server, configures agents on nodes
 - SELF_SERVE_demo - example of automated onboarding workflow using Github/PAS/DAP
 - SPLUNK_demo - Splunk integration demo
 - SPRING_demo - shows secrets injection for Spring resource files
 - HFTOKEN_demo - Host factory token lifecycle

## Works in progress (don't use)
 - new_K8S_apps_demo - K8S demos using workshop framework
 - wip_GO_demo
 - wip_TOWER_demo

