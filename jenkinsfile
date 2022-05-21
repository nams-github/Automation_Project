pipeline{
    //agent any
    agent {label 'worker'}
    options{
        buildDiscarder(logRotator(daysToKeepStr: '7'))
        disableConcurrentBuilds()
        retry(3)
        timeout(time: 1, unit: 'MINUTES')
    }
    parameters{
        string(name: 'BRANCH', defaultValue: 'master', description: 'Enter branch')
        choice(name: 'OPERATION', choices: ['A', 'B', 'C'])
    }
    stages{
        stage('Unit Testing'){
            steps{
                sh "echo hello C32"
            }
        }
        stage('Build '){
            steps{
                sh "echo hello C32"
                sh "sleep 10"
            }
        }
    }
}
