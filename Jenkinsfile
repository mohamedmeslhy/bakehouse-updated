pipeline {
  agent any
  stages {
    stage('start') {
      steps {
        echo "Gerges"
        script {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
           echo "hi"
          """
        }
        
      }
      }
    }
  }
}
