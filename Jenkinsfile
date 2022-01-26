pipeline {
  agent any
  stages {
    stage('start') {
      steps {
        echo "Gerges"
        script {
        cleanWs()
        git branch: env.BRANCH_NAME, credentialsId: 'dina-cred-github', url: scm.userRemoteConfigs[0].url
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
              docker login -u ${USERNAME} -p ${PASSWORD}
              docker build -t kareemelkasaby/bakehouse:latest .
              docker push kareemelkasaby/bakehouse:latest
          """
        }
        
      }
      }
    }
  }
}
