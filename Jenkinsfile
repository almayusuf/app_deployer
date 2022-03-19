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
properties([parameters([choice(choices: ['Dev', 'QA', 'Stage', 'Prod'], description: 'Please provide an environment to build', name: 'EnvironmentToBuild')])])  
node(POD_LABEL) {
    stage('Clone') {
      ws() {
          container('tools') {
          checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'gh', url: 'https://github.com/farrukh90/app_deployer.git']]])
            }
        }
    }

    stage('Authentication') {
      ws() {
          container('tools') {
                sh("gcloud auth activate-service-account --key-file=service-account.json")
                sh("gcloud container clusters get-credentials project-cluster --region us-central1")
            }
        }
    }
    stage('Init') {
      ws() {
          container('tools') {
          sh 'bash setenv.sh envs/${EnvironmentToBuild}.tfvars'
          sh 'terraform init'
            }
        }
    }
    stage('deploy') {
      ws() {
          container('tools') {
            // sh 'sleep 120'
            sh 'terraform apply -var-file envs/${EnvironmentToBuild}.tfvars -auto-approve'
            }
        }
    }
  }
}
