
#######################################   ConfigMap Imperatively   ########################################

## Literal Values
kubectl create configmap db-config --dry-run --from-literal=db=staging -o yaml > my-configmap.yaml
## Sigle file with environment variables
kubectl create configmap db-config --from-env-file=config.env
## Single file
kubectl create configmap db-config --from-file=config.txt
## Directory containing files
kubectl create configmap db-config --from-file=app-config


######################################## ConfigMaps Declaratively #########################################

## Create a ConfigMap that will will inject into container environment
kubectl apply -f configmap.yaml
## Values Injected into Container
kubectl apply -f injecting-configuration-pod.yaml
## Examine Environment Variables
kubectl exec configured-pod -- env

## Reassigning Values to Environment Variables
kubectl apply -f injecting-configmap-valuefrom.yaml
## Examine Environment Variables
kubectl exec configured-pod-reassigned-values -- env

## ConfigMap with mounted volume
kubectl apply -f pod-configmap-with-volume.yaml
## Examine Environment Variables
kubectl exec -it configured-pod-mounted-volume -- /bin/sh
## List all mounted configuration values
ls -1 /etc/config
## Examine database url
cat /etc/config/database_url
## Examine user
cat /etc/config/user

############################################# Create Secrets ######################################################

####################################### Create Secret Imperatively ################################################

## Literal Values
kubectl create secret generic db-secret --dry-run --from-literal=db=staging -o yaml > my-secret.yaml
## Single file with environment variables
kubectl create secret generic db-secret --from-env-file=config.env
## Single file
kubectl create secret generic db-secret --from-file=config.txt
## Directory containing files
kubectl create secret generic db-secret --from-file=secrets


############################################ Created Secrets Declaratively #########################################

# encode secret
echo -n 's3cre!' | base64

## Create a Secret that will will inject into container environment
kubectl apply -f secret-db-creds.yaml
# Create pod with injected secret
kubectl apply -f configured-pod-secret-injected.yaml
## Examine Secret
kubectl exec configured-pod-secret-injected -- env


## Create a Mounted secret pod
kubectl apply -f configured-pod-mounted-secret.yaml
## Examine Secret exec into container
kubectl exec -it configured-pod-mounted-secret-volume -- /bin/sh
## List all mounted secret values
ls -1 /etc/config
## Secret in pod
cat /etc/config/pwd




## Clean up
kubectl get po
kubectl delete -f configmap-configured-pod.yaml
kubectl delete -f injecting-configuration-pod.yaml
kubectl delete -f injecting-configmap-valuefrom.yaml
kubectl delete -f configured-pod-mounted-secret.yaml
kubectl delete -f configured-pod-secret-injected.yaml

kubectl delete -f configmap.yaml
kubectl delete -f secret-db-creds.yaml
