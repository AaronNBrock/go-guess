pipeline {
  agent {
    docker {
      image 'golang'
    }

  }
  stages {
    stage('Make docker-deploy') {
      steps {
        echo 'Hello, World'
        sh 'make docker-deploy'
      }
    }
  }
}