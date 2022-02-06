job "reart" {
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

  group "reart" {
    count = 3 
    network {
      port "http" {
        to = 5006
      }
    }
    restart {
      attempts = 2
      interval = "5s"
      delay    = "1s"
      mode     = "fail"
    }

    task "reart" {
      driver = "docker"
      config {
        image = "nand0p/reart:latest"
        ports = ["http"]
      }

      service {
        name         = "${TASKGROUP}-service"
        port         = "http"
        #address_mode = "driver"
        tags         = ["reart", "urlprefix-/"]
        check {
          name         = "reart"
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
        memory = 10
      }

      logs {
        max_files     = 10
        max_file_size = 15
      }

      kill_timeout = "1s"
    }
  }
}
