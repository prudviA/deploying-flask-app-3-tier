pipeline {
  agent any

  environment {
    TF_DIR = 'terraform'
    IMAGE = "prudhviachuth/devsecops-app:latest-${BUILD_NUMBER}"
    CLUSTER = 'devsecops-cluster'
    REGION = 'ap-south-1'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/prudviA/deploying-flask-app-3-tier.git'
      }
    }

    stage('Terraform Init & Apply') {
      steps {
        dir("${TF_DIR}") {
          sh 'terraform init'
          sh 'terraform apply -auto-approve'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh '''
        docker build -t $IMAGE .
        docker push $IMAGE
        '''
      }
    }

    stage('Trivy Scan') {
      steps {
        sh 'trivy image $IMAGE || true'
      }
    }

    stage('Deploy to EKS') {
      steps {
        sh '''
        aws eks update-kubeconfig --region $REGION --name $CLUSTER
        kubectl apply -f k8s-manifests/
        '''
      }
    }

    stage('DAST Scan with OWASP ZAP') {
      steps {
        sh 'zap-cli quick-scan http://your-app-alb-url'
      }
    }
  }
}
