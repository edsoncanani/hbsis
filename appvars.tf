# Nome da Aplicacao
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

#Ambiente
variable "environment" {
  type        = string
}

#Local
variable "location" {
  type        = string
}

#Descricao
variable "description" {
  type        = string
}