# AWS-Kubernetes-Cluster-Pipeline

In this project, I've successfully orchestrated a Kubernetes cluster using kubeadm on AWS, configuring three virtual machines—one master node and two worker nodes. The cluster setup was streamlined with kubeadm, which played a crucial role in initializing the master node and joining the worker nodes, ensuring efficient cluster management. GitHub Actions facilitated the automated deployment of Terraform Infrastructure as Code (IAC) for creating the Virtual Machines and their dependencies. Additionally, I developed a Ansible Playbook that uses three custom bash scripts to automate the installation of Kubernetes components like kubeadm, kubelet, and kubectl on each VM, which paved the way for a seamless cluster formation. To bolster security, the integration of Snyk provides vigilant vulnerability monitoring for my IAC code and ensuring a robust, secure infrastructure for application deployment and management.

## Architecture Breakdown

![app](https://github.com/rjones18/Images/blob/main/AWS%20Kubernetes%20Cluster%20(1).png)
