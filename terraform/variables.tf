variable "project" {
  type = map(string)
}

variable "domain" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "owner" {
  type = string
}

variable "repo" {
  type = string
}

variable "web_user" {
  type = string
}

variable "web_password" {
  type = string
}
