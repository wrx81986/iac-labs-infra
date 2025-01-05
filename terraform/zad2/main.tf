terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.24.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_tag" "tag_<indeks>" {
  source_image = "existing_image_name"   # Nazwa obrazu źródłowego
  target_image = "new_image_name"       # Nazwa obrazu docelowego
  tag          = "new_tag"              # Nowy tag (np. v1.0)
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8080
  }
}

output "address" {
  value = "http://localhost:${docker_container.nginx.ports[0].external}"
}
