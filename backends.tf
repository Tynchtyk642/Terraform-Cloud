terraform {
  cloud {
    organization = "future-devopses"

    workspaces {
      name = "cli-driven"
    }
  }
}
