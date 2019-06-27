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

The [HashiStack-HA AWS 2019](./HashStack-HA-2019) provisions a 9 node HashiStack cluster. The 6 Consul & Vault agents are running 3 server and 3 agent nodes, while Nomad is running 3 nodes in both Client & Server mode. 


## Process

We will now provision the HashiStack cluster.

### Step 1: Setup your environment
1. Install PuTTY and PuTTYGen (https://www.puttygen.com/download-putty#PuTTY_for_windows)
2. Make sure you have an AWS Account
3. Set your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY (See Environmental Variables in (https://www.terraform.io/docs/providers/aws/index.html)
4. Create EC2 key pair and save .pem file next to this readme (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
5. Convert .pem file to "putty_key.ppk" via puttyGen (See first answer on https://stackoverflow.com/questions/3190667/convert-pem-to-ppk-file-format)
6. Place .ppk file in your root folder next to this readme
7. Go to (https://www.terraform.io/downloads.html) download terraform and place the binary in your system path
8. Go to (https://www.packer.io/downloads.html) download packer and place the binary in your system path

### Step 2: Build your AMIs - Got to make the blocks before you use them

#### Note: I used power shell to run all the commands from here on


1. 'cd' into the "vault-consul-ami"
2. run 'packer build ./vault-consul.json'
3. take note of the ami-id
4. 'cd' into the "nomad-ami"
5. run 'packer build ./nomad.json'
6. take note of the ami-id


### Step 3: Provision infrastructor in AWS - Now we get to have some fun and actually create our system!


1. 'cd' into HashStack-HA-2019
2. open variables.tf in your editor of choice
3. set "vault_ami_id" and "consul_ami_id" to the first ami-id you created above
4. set "nomad_ami_id" to the second ami-id from above
5. set "ssh_key_name" to the name you of your .pem file from above (no extension please)
6. run "Terraform init"
7. run "Terraform plan" select a region => if you have any errors here please post to the repo and I will try to help resolve them
8. run "Terraform Apply" select a region and say "yes"

## IT'S ALIVE!!!


### Step 4: Connect to servers - All that is left is to say Hi


 1. Go to your AWS console and pick an EC2 instance for vault
 2. Copy the Publice DNS name
 3. Open Putty and paste "ec2-user@"'Your DNA Name' into the host name
 4. On the left select Connection -> SSH -> Auth and browse for you .ppk file
 5. click "open"
 6. In the promopt that appears run "vault version" and make sure you get a version number back.

repeat the above process with Nomad and Consul

## Next Steps

Now that you've provisioned and configured the HashiStack, start walking through the below product guides.

- [Consul Guides](https://www.consul.io/docs/guides/index.html)
- [Vault Guides](https://www.vaultproject.io/guides/index.html)
- [Nomad Guides](https://www.nomadproject.io/guides/index.html)