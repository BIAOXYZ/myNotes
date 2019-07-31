
# debug tool general

Debugging microservices - Squash vs. Telepresence https://www.weave.works/blog/debugging-microservices-squash-vs-telepresence
- Telepresence https://www.telepresence.io/
- Squash: The debugger for microservices https://squash.solo.io/

Solving the challenges of debugging microservices on a container platform https://developers.redhat.com/blog/2018/11/27/microservices-debugging-openshift-kubernetes/

# Telepresence

TELEPRESENCE: FAST, LOCAL DEVELOPMENT FOR KUBERNETES AND OPENSHIFT MICROSERVICES https://www.telepresence.io/

Debug a Kubernetes service locally https://www.telepresence.io/tutorials/kubernetes

k8s官方推荐了`telepresence`:
- Developing and debugging services locally https://kubernetes.io/docs/tasks/debug-application-cluster/local-debugging/
- 本地开发和调试 service https://k8smeetup.github.io/docs/tasks/debug-application-cluster/local-debugging/

# Squash

Squash https://squash.solo.io/

Squash: The debugger for microservices https://github.com/solo-io/squash

# not matured 

## kubectl-debug

简化 Pod 故障诊断: kubectl-debug 介绍 https://aleiwu.com/post/kubectl-debug-intro/
- nsenter https://github.com/jpetazzo/nsenter
  * > There are differences between nsenter and docker exec; namely, nsenter doesn't enter the cgroups, and therefore evades resource limitations. The potential benefit of this would be debugging and external audit, but for remote access, docker exec is the current recommended approach.

## docker-debug

docker 容器调试新姿势 https://blog.zeromake.com/pages/docker-debug
