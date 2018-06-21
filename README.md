# terraform-jenkins-x

Module Jenkins-x for Terraform

## Initial phase of development

## Caution: Do not use this module in production.

Only test

## Step 1 - Create Cluster GCE

```shell

gcloud beta container --project "virti-proj-1" clusters create "cluster-2" \
--zone "us-central1-a" \
--username "admin" \
--cluster-version "1.9.7-gke.3" \
--machine-type "n1-standard-2" \
--image-type "COS" \
--disk-type "pd-standard" \
--disk-size "100" \
--scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
--num-nodes "2" \
--enable-cloud-logging \
--enable-cloud-monitoring \
--network "default" \
--subnetwork "default" \
--addons HorizontalPodAutoscaling,HttpLoadBalancing,KubernetesDashboard \
--no-enable-autoupgrade \
--enable-autorepair
```


## Step 2 - Get files

```shell

  $ git clone https://github.com/petersonwsantos/terraform-jenkins-x.git
  $ git checkout core
  $ cd terraform-jenkins-x
  $ cp terraform.tfvars_example terraform.tfvars
  $ vim terraform.tfvars

```

## Step 3 - Prepare variables

``` shell

# your git username  
git_user = "my_git_user"

# ( * ) personal access token
git_token = "a848dsfgsfggsdfc6f3dfdfsd5ddfd4530ee4cca4b076bc"

# username admin jenkins-x
admin_user = "admin"

# password admin jenkins-x
admin_password = "1q2w3e4a"

# ( ** ) password JXBasicAuth
admin_password_jxbasicauth = "jTy/Hipu$Azmac9UkQHHn3YXxC4Rpv/"
admin_password_jxbasicauth_values = "admin:$apr1$jTy/Hipu$Azmac9UkQHHn3YXxC4Rpv/"

# context
kubernetes_context = "gke_virti-proj-1_us-central1-a_cluster-2"

```

( * ) personal access token

  [Click in this link to create git tokem](https://github.com/settings/tokens/new?scopes=repo,read:user,user:email,write:repo_hook)

( ** ) variables `admin_password_jxbasicauth` and `admin_password_jxbasicauth_values`

```shell

$ htpasswd -nb admin 1q2w3e4a
admin:$apr1$jTy/Hipu$Azmac9UkQHHn3YXxC4Rpv/

# admin_password_jxbasicauth = "jTy/Hipu$Azmac9UkQHHn3YXxC4Rpv/"
# admin_password_jxbasicauth_values = "admin:$apr1$jTy/Hipu$Azmac9UkQHHn3YXxC4Rpv/"
```


## Step 4 - Test module

```shell

terraform init  
terraform plan
terraform apply -auto-approve

```
