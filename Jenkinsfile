pipeline {
    agent any
    environment {
        // ID của Credentials (User/Pass) bạn đã tạo trong Jenkins
        VM_AUTH = 'vm-password-char'
        VM_IP = '192.168.183.101' // Thay bằng IP máy ảo của bạn
        VM_USER = 'reatimo'
        PROJECT_DIR = '/root/jenkins-demo'
    }
    stages {
        stage('Deploy to VMware') {
            steps {
                script {
                    def remote = [:]
                    remote.name = 'vmware-server'
                    remote.host = env.VM_IP
                    remote.user = env.VM_USER
                    remote.allowAnyHosts = true

                    withCredentials([usernamePassword(credentialsId: env.VM_AUTH, passwordVariable: 'pass', usernameVariable: 'user')]) {
                        remote.password = pass

                        // Chuỗi lệnh thực hiện trên máy ảo
                        // 1. Vào thư mục dự án
                        // 2. Git pull code mới
                        // 3. Dừng và xóa container cũ
                        // 4. Build lại image mới (không dùng cache để đảm bảo code mới nhất)
                        // 5. Chạy container mới ở chế độ nền (-d)
                        sshCommand remote: remote, command: """
                            cd ${env.PROJECT_DIR} && \
                            git pull origin main && \
                            docker-compose down && \
                            docker-compose build --no-cache && \
                            docker-compose up -d
                        """
                    }
                }
            }
        }
    }
}
