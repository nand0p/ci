job "covid19" {
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
    min_healthy_time = "5s"
    healthy_deadline = "10s"
  }

  group "covid19" {
    count = 3 
    network {
      port "http" {
        to = 5000
        #static = 5000
      }
    }
    restart {
      attempts = 2
      interval = "5s"
      delay    = "1s"
      mode     = "fail"
    }

    task "covid19" {
      driver = "docker"
      config {
        image = "nand0p/covid19:latest"
        ports = ["http"]
      }

      service {
        name         = "${TASKGROUP}-service"
        port         = "http"
        address_mode = "driver"
        tags         = ["covid19", "urlprefix-/"]
        check {
          name         = "covid19"
          port         = "http"
          interval     = "5s"
          timeout      = "2s"
          type         = "tcp"
        }
      }

      resources {
        cpu    = 20
        memory = 400
      }

      logs {
        max_files     = 10
        max_file_size = 15
      }

      kill_timeout = "1s"
    }
  }
}
