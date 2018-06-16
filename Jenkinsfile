pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('Make docker-deploy') {
      steps {
        sh 'make docker-deploy'
      }
    }
  }
}