pipeline {
  agent { label 'slave-agent-node' }
  stages {
    stage('start') {
      steps {
        echo "Gerges"
        script {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
              docker login -u ${USERNAME} -p ${PASSWORD}
              docker build -t mohamedmoselhy110/bakehouse:latest .
              docker push mohamedmoselhy110/bakehouse:latest

          """
        }
        
      }
      }
    }
  }
}
