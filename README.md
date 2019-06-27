# HashiStack-HA AWS 2019 

The goal of this guide is to allows users to easily provision the HashiStack in a high avalibility configuration in just a few short commands.

## Reference Material

- [Packer](https://www.packer.io/)
- [Terraform](https://www.terraform.io/)
- [Consul](https://www.consul.io/)
- [Vault](https://www.vaultproject.io/)
- [Nomad](https://www.nomadproject.io/)

## Estimated Time to Complete

15 minutes.

## Personas

### Operator

The operator is responsible for producing the HashiStack infrastructure and managing day 1 & 2 operations. This includes initial service administration, upgrades, and logging/monitoring, and more.

### Developer

The developer will be consuming the HashiStack services and developing against it. This may be leveraging Consul for Service Discovery, Vault for Secrets Management, or Nomad for application deployment.

### InfoSec

Infosec will be creating and managing policies for the HashiStack. This may include both ACLs and Sentinel policies across Terraform, Consul, Vault, and Nomad.

## Challenge

For educational purposes, standing up highly avaliable, instances of Consul, Nomad and Vault within the AWS free teer limits.

## Solution

This solution stands up nine servers (6 of consul/vault and 3 of nomad) inside an AWS VPC with other supporting infrastructure.

**Disclaimer**: No matter which guide you follow, the HashiStack is _not_ considered best practices. Each product (Consul/Vault/Nomad) should be provisioned and managed separately. The "HashiStack" is merely a convenient way to provision a cluster that has all the HashiCorp tools you need.


### Quick Start

The [HashiStack Quick Start Guide](./quick-start) provisions a 9 node HashiStack cluster. The 6 Consul & Vault agents are running 3 server and 3 agent nodes, while Nomad is running 3 nodes in both Client & Server mode. 


## Steps

We will now provision the HashiStack cluster.

### Step 1: Setup your environment
- Install PuTTY and PuTTYGen (https://www.puttygen.com/download-putty#PuTTY_for_windows)
- Make sure you have an AWS Account
- Set your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY (See Environmental Variables in (https://www.terraform.io/docs/providers/aws/index.html)
- Create EC2 key pair and save .pem file next to this readme (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
- Convert .pem file to "putty_key.ppk" via puttyGen (See first answer on https://stackoverflow.com/questions/3190667/convert-pem-to-ppk-file-format)
- Place .ppk file in your root folder next to this readme

### Step 2: Build your AMIs
#Note: I used power shell to run all the commands from here on
- 'cd' into the "vault-consul-ami"
- run 'packer build ./vault-consul.json'
- take note of the ami-id

- 'cd' into the "nomad-ami"
- run 'packer build ./nomad.json'
- take note of the ami-id

### Step 3: Provision infrastructor in AWS
- 'cd' into HashStack-HA-2019
- open variables.tf in your editor of choice
- set "vault_ami_id" and "consul_ami_id" to the first ami-id you created above
- set "nomad_ami_id" to the second ami-id from above
- set "ssh_key_name" to the name you of your .pem file from above (no extension please)

- run "Terraform init"
- run "Terraform plan" => if you have any errors here please post to the repo
- run "Terraform Apply" select a region and say "yes"

### IT'S ALIVE!!!

### Step 4: Connect to servers 





## Next Steps

Now that you've provisioned and configured the HashiStack, start walking through the below product guides.

- [Consul Guides](https://www.consul.io/docs/guides/index.html)
- [Vault Guides](https://www.vaultproject.io/guides/index.html)
- [Nomad Guides](https://www.nomadproject.io/guides/index.html)