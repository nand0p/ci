job "reimage" {
  datacenters = ["dc-aws-001"]
  type        = "service"
  priority    = 50

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  update {
    stagger          = "1s"
    max_parallel     = 3
    min_healthy_time = "1s"
    healthy_deadline = "10s"
  }

  group "reimage" {
    count = 3 
    network {
      port "http" {
        to = 5000 
      }
    }
    restart {
      attempts = 2
      interval = "5s"
      delay    = "1s"
      mode     = "fail"
    }

    task "reimage" {
      driver = "docker"
      config {
        image = "nand0p/reimage:latest"
        ports = ["http"]
      }

      service {
        name         = "${TASKGROUP}-service"
        port         = "http"
        #address_mode = "driver"
        tags         = ["hex7", "urlprefix-/"]
        check {
          name         = "reimage"
          #address_mode = "driver"
          port         = "http"
          interval     = "5s"
          timeout      = "2s"
          type         = "tcp"
          #type         = "http"
          #path         = "/"
        }
      }

      resources {
        cpu    = 10
        memory = 200
      }

      logs {
        max_files     = 10
        max_file_size = 15
      }

      kill_timeout = "1s"
    }
  }
}
