podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: tools
        image: docker.projectxconsulting.net/tools:latest
        command:
        - sleep
        args:
        - 99d
      imagePullSecrets:
      - name: regcred
''') {
  properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5'))])
  node(POD_LABEL) {
    stage('Clone') {
      ws() {
          container('tools') {
          checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'gh', url: 'https://github.com/farrukh90/custom_helm.git']]])
            }
        }
    }

    stage('Terraform') {
      ws() {
          container('tools') {
            withCredentials([file(credentialsId: 'k8s', variable: 'GC_KEY')]) {
                sh("gcloud auth activate-service-account --key-file=${GC_KEY}")
                sh("gcloud container clusters get-credentials project-cluster --region us-central1")

                }
            }
        }
    }
    stage('Init') {
      ws() {
          container('tools') {
          sh 'bash setenv.sh'
          sh 'terraform init'
            }
        }
    }
    stage('deploy') {
      ws() {
          container('tools') {
            // sh 'sleep 120'
            sh 'terraform apply -var-file envs/dev.tfvars -auto-approve'
            }
        }
    }
  }
}