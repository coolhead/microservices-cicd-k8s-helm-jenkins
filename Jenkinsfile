pipeline {
  agent any
  environment {
    IMAGE_TAG = "latest"
    NAMESPACE = "dev"
    HELM_CHART_DIR = "helm-chart"
  }
  stages {
    stage('Build Docker Images') {
      steps {
        script {
	  sh 'eval $(minikube -p minikube docker-env)'
          sh 'docker build -t web:${IMAGE_TAG} ./web'
          sh 'docker build -t auth:${IMAGE_TAG} ./auth'
        }
      }
    }

    stage('Deploy with Helm') {
      steps {
        script {
          sh "helm upgrade --install devstack ${HELM_CHART_DIR} -n ${NAMESPACE} --create-namespace"
        }
      }
    }
  }
}

