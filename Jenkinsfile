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

                    // Run Robot Framework tests using virtual environment
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

        stage('Print Summary') {
            steps {
                script {
                    // Print a brief summary from output.xml
                    sh """
                    echo "===== Robot Test Summary ====="
                    xmllint --xpath "string(//statistics/total/@pass)" ${ROBOT_RESULTS_DIR}/output.xml
                    echo " tests passed"
                    """
                }
            }
        }
        stage('Serve Reports') {
            steps {
                script {
                    sh """
                    cd ${ROBOT_RESULTS_DIR}
                    nohup python3 -m http.server 8081 &
                    """
                }
            }
        }
        stage('Copy Reports Locally') {
            steps {
                sh """
                mkdir -p ~/robot_reports
                cp -r ${ROBOT_RESULTS_DIR}/* ~/robot_reports/
                """
            }
        }
        stage('Publish Robot Results') {
            steps {
                robot outputPath: "${ROBOT_RESULTS_DIR}"
            }
        }
    }
}
