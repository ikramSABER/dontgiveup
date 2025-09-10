pipeline {
    agent any

    environment {
        ROBOT_RESULTS_DIR = 'results'
        VENV_PATH = '/opt/venv/bin'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Robot Test') {
            steps {
                script {
                    // Ensure results directory exists
                    sh "mkdir -p ${ROBOT_RESULTS_DIR}"

                    // Run Robot Framework test inside the venv
                    sh """
                    ${VENV_PATH}/robot \
                        -d ${ROBOT_RESULTS_DIR} \
                        tests/google_search.robot
                    """
                }
            }
        }

        stage('Archive Reports') {
            steps {
                // Archive Robot Framework output
                archiveArtifacts artifacts: "${ROBOT_RESULTS_DIR}/*.html, ${ROBOT_RESULTS_DIR}/*.xml"
            }
        }

        stage('Publish Robot Results') {
            steps {
                // Publish Robot Framework results if plugin is installed
                robot outputPath: "${ROBOT_RESULTS_DIR}"
            }
        }
    }
}
