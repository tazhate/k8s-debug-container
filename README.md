# k8s-debug-container

Specialized debug container images for Kubernetes troubleshooting. Multi-arch support (amd64 + arm64).

## Quick Start

```bash
# Minimal debug shell (~60MB)
kubectl run -it --rm debug --image tazhate/k8s-debug-container-minimal -- bash

# Network debugging
kubectl run -it --rm debug --image tazhate/k8s-debug-container-net -- bash

# Stress testing
kubectl run -it --rm debug --image tazhate/k8s-debug-container-stress -- bash
```

## kubectl-debug Script

Install helper script for easier usage:

```bash
# Install
sudo curl -fsSL https://raw.githubusercontent.com/tazhate/k8s-debug-container/main/scripts/kubectl-debug \
  -o /usr/local/bin/kubectl-debug && sudo chmod +x /usr/local/bin/kubectl-debug

# Usage
kubectl-debug              # minimal (default)
kubectl-debug net          # network tools
kubectl-debug stress       # stress testing
kubectl-debug db -n prod   # database tools in namespace
```

## Images

| Image | Size | Use Case |
|-------|------|----------|
| [`-minimal`](https://hub.docker.com/r/tazhate/k8s-debug-container-minimal) | ~60MB | Quick diagnostics |
| [`-net`](https://hub.docker.com/r/tazhate/k8s-debug-container-net) | ~400MB | Network issues |
| [`-db`](https://hub.docker.com/r/tazhate/k8s-debug-container-db) | ~350MB | Database connectivity |
| [`-k8s`](https://hub.docker.com/r/tazhate/k8s-debug-container-k8s) | ~500MB | Cluster management |
| [`-storage`](https://hub.docker.com/r/tazhate/k8s-debug-container-storage) | ~300MB | Disk/IO problems |
| [`-perf`](https://hub.docker.com/r/tazhate/k8s-debug-container-perf) | ~350MB | Performance profiling |
| [`-stress`](https://hub.docker.com/r/tazhate/k8s-debug-container-stress) | ~250MB | Load testing |
| [`-full`](https://hub.docker.com/r/tazhate/k8s-debug-container-full) | ~1.2GB | Everything |

## Tools Reference

### minimal (Alpine-based)
```
curl, wget, dig, nslookup, jq, vim, tcpdump, mtr, netcat, openssl
```

### net
```
tcpdump, nmap, netcat, iperf3, dig, traceroute, mtr, curl, wget,
httpie, socat, tshark, iftop, bmon, hping3, ngrep, whois
```

### db
```
psql, mysql, redis-cli, mongosh, sqlite3
```

### k8s
```
kubectl, helm, k9s, stern, kubectx, kubens, kustomize, yq, jq, bat, fzf
```

### storage
```
fio, iotop, hdparm, smartctl, ncdu, rclone, mc (MinIO), s3cmd
```

### perf
```
htop, iotop, strace, ltrace, perf, bpfcc-tools, dstat, atop, nmon,
stress-ng, sysbench
```

### stress
```
stress-ng, sysbench, fio, iperf3, ioping, bonnie++, hey,
htop, dstat, sysstat
```

### full
All tools from all images above.

## Common Use Cases

### DNS Debugging
```bash
kubectl run -it --rm debug --image tazhate/k8s-debug-container-net -- bash
# Inside container:
dig kubernetes.default.svc.cluster.local
nslookup my-service.namespace.svc.cluster.local
```

### Network Connectivity
```bash
kubectl run -it --rm debug --image tazhate/k8s-debug-container-net -- bash
# Inside container:
curl -v http://my-service:8080/health
tcpdump -i any port 8080
iperf3 -c target-pod -p 5201
```

### Database Connection Test
```bash
kubectl run -it --rm debug --image tazhate/k8s-debug-container-db -- bash
# Inside container:
psql -h postgres-service -U user -d mydb
mysql -h mysql-service -u user -p
redis-cli -h redis-service ping
mongosh mongodb://mongo-service:27017
```

### Storage Performance
```bash
kubectl run -it --rm debug --image tazhate/k8s-debug-container-storage -- bash
# Inside container:
fio --name=randread --rw=randread --bs=4k --size=1G --runtime=60
ioping -c 10 /data
```

### Stress Testing
```bash
kubectl run -it --rm debug --image tazhate/k8s-debug-container-stress -- bash
# Inside container:
# CPU stress (4 workers for 60s)
stress-ng --cpu 4 --timeout 60s --metrics

# Memory stress (2GB for 30s)
stress-ng --vm 2 --vm-bytes 1G --timeout 30s

# Disk I/O stress
fio --name=stress --rw=randrw --bs=4k --size=512M --numjobs=4

# HTTP load test
hey -n 10000 -c 100 http://my-service:8080/
```

### CPU/Memory Profiling
```bash
kubectl run -it --rm debug --image tazhate/k8s-debug-container-perf -- bash
# Inside container:
htop
perf top
strace -p <PID>
```

## Debug Ephemeral Container (K8s 1.23+)

Attach debug container to running pod:

```bash
kubectl debug -it my-pod --image=tazhate/k8s-debug-container-net --target=my-container -- bash
```

## Building

```bash
# Build single image
make build-minimal
make build-net
make build-stress

# Build all
make build-all

# Multi-arch build and push
make buildx-all
```

## License

MIT
