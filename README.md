## Module Terraform for Jenkins-x

##### Initial phase of development

##### Caution: Do not use this module in production.

Only test

### Step 1 - Create Cluster GCE

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


### Step 2 -  

```shell

  $ git clone https://github.com/petersonwsantos/terraform-jenkins-x.git
  $ cd terraform-jenkins-x
  $ cp terraform.tfvars_example terraform.tfvars
  $ vim terraform.tfvars

```

### Step 3 - Prepare variables

``` shell
admin_user = "admin"

admin_password = "1q2w3e4a"

kubernetes_context = "gke_virti-proj-1_us-central1-a_cluster-1"

jx_provider = "kubernetes"

git_provider_url = "https://github.com"

git_owner = "opstricks"

git_user = "opstricks"

# https://github.com/settings/tokens/new?scopes=repo,read:user,user:email,write:repo_hook
git_token = "fcfa8bb880640e4e347ffed18ae7d88cb3de07db"

```

### Step 4 - Test module

```shell

terraform init  
terraform plan
terraform apply -auto-approve

```
