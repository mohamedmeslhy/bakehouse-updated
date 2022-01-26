pipeline {
  agent { label 'slave-agent-node' }
  stages {
    stage('start') {
      steps {
      
        script {
        withCredentials([file(credentialsId: 'mmoselhy110', variable: 'k8s_config')]) {
          sh """
              gcloud container clusters get-credentials my-gke-cluster --region us-central1 --project active-sun-337308
              kubectl apply -f . --kubeconfig=$k8s_config
          """
        }
        
      }
      }
    }
  }
}
