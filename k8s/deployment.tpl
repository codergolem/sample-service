apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-app
  labels:
    app: sample-app
spec:
  replicas: 2
  progressDeadlineSeconds: 600
  revisionHistoryLimit: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 50%
      maxUnavailable: 0
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
    spec:
      containers:
        - image: ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${ECR_REPOSITORY}:${VERSION}
          name: sample-app
          resources:
            limits:
              cpu: "256m"
              memory: "256M"
            requests:
              cpu: "128m"
              memory: "128M"
          ports:
            - containerPort: 80
          readinessProbe:
            httpGet:
              path: /health
              port: 80
            initialDelaySeconds: 15
            timeoutSeconds: 2
            periodSeconds: 15
          livenessProbe:
            httpGet:
              path: /health
              port: 80