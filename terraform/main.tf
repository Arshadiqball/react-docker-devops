provider "null" {
  # Null provider to run local-exec provisioner
}

resource "null_resource" "run_react_app" {

  # Install Docker (for Windows PowerShell)
  provisioner "local-exec" {
    command = <<EOT
      if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
        Write-Host "Docker is not installed. Installing Docker..."
        choco install docker-desktop -y
        Start-Sleep -s 20
      } else {
        Write-Host "Docker is already installed."
      }
    EOT
    interpreter = ["PowerShell", "-Command"]
  }

  # Run the Docker container for the React app
  provisioner "local-exec" {
    command = <<EOT
      docker pull ghcr.io/yourusername/task-manager-app:latest
      docker run -d -p 3000:80 ghcr.io/arshadiqball/react-app-deployment:latest
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
}
