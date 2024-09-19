provider "null" {}

resource "null_resource" "run_react_app" {

  # Use a random trigger (e.g., git commit hash) to force redeployment
  triggers = {
    always_run = "${timestamp()}"
  }

  # Install Docker (this assumes Docker is not installed; if already installed, this step is optional)
  provisioner "local-exec" {
    command = <<EOT
      if ! [ -x "$(command -v docker)" ]; then
        echo "Docker is not installed. Installing Docker..."
        sudo apt update
        sudo apt install -y docker.io
      else
        echo "Docker is already installed."
      fi
    EOT
  }

  # Run the Docker container for the React app
  provisioner "local-exec" {
    command = <<EOT
      docker pull ghcr.io/yourusername/task-manager-app:latest
      docker run -d -p 3000:80 ghcr.io/yourusername/task-manager-app:latest
    EOT
  }
}
