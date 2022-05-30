# Deploy an application

### Configure backend :
```
bash setenv.sh envs/dev.tfvars
```

### Initialize
```
terraform init
```

### Deploy

```
terraform apply -var-file envs/dev.tfvars 
```

### Verify
#### Ensure pod created and running
```
kubectl get po -n dev
```

#### Get ingress and past to browser to see it works
```
kubectl get ingress -n dev --auto-approve
```
