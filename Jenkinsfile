pipeline {
  environment {
    registry = "balajikoppala9700/shopping_cart"
    registryCredential = 'docker_hub_balajikoppala9700'
    dockerImage = ''
  }
  agent any
  stages{
    stage ('Build') {
      steps{
        echo "Building Project"
        sh 'npm run ng --build  --prod'
      }
    }
    stage ('Archive') {
      steps{
        echo "Archiving Project"
        archiveArtifacts artifacts: '*/.jar', followSymlinks: false
      }
    }
    stage ('Build Docker Image') {
      steps{
        echo "Building Docker Image"
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage ('Push Docker Image') {
      steps{
        echo "Pushing Docker Image"
        script {
          docker.withRegistry( '', registryCredential ) {
              dockerImage.push()
              dockerImage.push('latest')
          }
        }
      }
    }
    stage ('Deploy to Dev') {
      steps{
        echo "Deploying to Dev Environment"
        sh "docker rm -f angular7-sample || true"
        sh "docker run -d --name=angular7-sample -p 8081:8080 balajikoppala9700/shopping_cart"
      }
    }
  }
}
