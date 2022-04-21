CONTAINERISED K9S
=================


This app runs k9s, kubectl and helm commands via a docker container.


# Examples

```
# Create an alias to simplify command line
[ec2-user@ip-10-11-12-13 ~]$ alias ks='docker run -it --rm awilmore/k9s:latest my-cluster-name'

```

```
# List nodes on my-cluster-name cluster
[ec2-user@ip-10-11-12-13 ~]$ docker-k9s kubectl get nodes
Added new context arn:aws:eks:ap-southeast-2:812111111111:cluster/my-cluster-name to /root/.kube/config
NAME                                          STATUS                     ROLES    AGE     ...
ip-10-9-8-7.ap-southeast-2.compute.internal   Ready                      <none>   7d20h   ...
ip-10-9-8-8.ap-southeast-2.compute.internal   Ready                      <none>   2d22h   ...
ip-10-9-8-9.ap-southeast-2.compute.internal   Ready,SchedulingDisabled   <none>   2d3h    ...

```

```
# List helm charts in ops namespace
[ec2-user@ip-10-11-12-13 ~]$ docker-k9s helm -n ops list
Added new context arn:aws:eks:ap-southeast-2:812111111111:cluster/my-cluster-name to /root/.kube/config
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS   ...
kube-app        ops             5               2021-10-21 03:58:22.854749432 +0000 UTC deployed ...
node-app        ops             13              2021-10-21 01:05:23.642647449 +0000 UTC deployed ...

```

```
# Start k9s session
[ec2-user@ip-10-11-12-13 ~]$ docker-k9s k9s
Added new context arn:aws:eks:ap-southeast-2:812111111111:cluster/my-cluster-name to /root/.kube/config
...

```
