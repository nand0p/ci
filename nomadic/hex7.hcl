job "hex7" {
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

  group "hex7" {
    count = 3 
    network {
      port "http" {
        to = 31000
        #static = 31000
      }
    }
    restart {
      attempts = 2
      interval = "5s"
      delay    = "1s"
      mode     = "fail"
    }

    task "hex7" {
      driver = "docker"
      config {
        image = "nand0p/hex7:latest"
        ports = ["http"]
      }

      service {
        name         = "${TASKGROUP}-service"
        port         = "http"
        #address_mode = "driver"
        tags         = ["hex7", "urlprefix-/"]
        check {
          name         = "hex7"
          #address_mode = "driver"
          port         = "http"
          interval     = "5s"
          timeout      = "2s"
          type         = "tcp"
          #type         = "http"
          #path         = "/"
        }
      }

      env {
        FLASK_RUN_PORT = "31000"
        FLASK_ENV = "production"
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
