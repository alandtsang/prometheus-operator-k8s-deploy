# prometheus-operator-k8s-deploy
Deploy prometheus-operator with helm

## Dependency
If you don't have helm installed, please install helm first.

Please download the helm that matches your system.

https://github.com/helm/helm/releases

```
$ wget https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz
$ tar xf helm-v2.14.3-linux-amd64.tar.gz
$ sudo mv linux-amd64/helm /usr/local/bin
```

```
$ helm version
Client: &version.Version{SemVer:"v2.14.3", GitCommit:"0e7f3b6637f7af8fcfddb3d2941fcc7cbebb0085", GitTreeState:"clean"}
Error: cannot connect to Tiller
```

Install Tiller:
```
helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.3 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
```

Create `rbac-config.yaml` file:
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
```

```
kubectl create -f rbac-config.yaml
```

```
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

## Usage

```
$ git clone https://github.com/alandtsang/prometheus-operator-k8s-deploy.git
$ cd prometheus-operator-k8s-deploy
```

Install the prometheus-operator, and namespace is monitoring.
```
make install
```

You can use this command when you want to change the release configuration.
```
make upgrade
```

Removes all the Kubernetes components associated with the chart and deletes the prometheus-operator.
```
make delete
```

CRDs created by this chart are not removed by default and should be manually cleaned up.
```
make clean-crd
```

# Get Help
The fastest way to get response is to send email to my mail:
- <zengxianglong0@gmail.com>
