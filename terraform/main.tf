provider "null" {}

resource "null_resource" "run_react_app" {

  # Use PowerShell to check if Docker is installed, and install it if necessary
  provisioner "local-exec" {
    command = <<EOT
      if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
        Write-Host "Docker is not installed. Installing Docker..."
        choco install docker-desktop -y
      } else {
        Write-Host "Docker is already installed."
      }
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
  
  # Run the Prometheus container (using docker-compose.yml inside the prometheus folder)
  provisioner "local-exec" {
    command = <<EOT
      docker-compose -f ./../prometheus/docker-compose.yml up -d --build
    EOT
    interpreter = ["PowerShell", "-Command"]
  }

  # Run the Docker container for the React app
  provisioner "local-exec" {
    command = <<EOT
      docker pull ghcr.io/arshadiqball/react-app-deployment:latest
      docker run -d -p 3000:80 ghcr.io/arshadiqball/react-app-deployment:latest 
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
}
