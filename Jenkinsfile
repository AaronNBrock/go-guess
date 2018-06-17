pipeline {
  agent {
    dockerfile {
      filename 'build.dockerfile'
    }
  }
  stages {
    stage('Say Hello') {
      steps {
        echo 'Hello, World'
      }
    }
  }
}