variable "firewall_sku_tier" {
  type        = string
  description = "Firewall SKU."
  default     = "Premium" # Valid values are Standard and Premium
  validation {
    condition = contains(["Standard", "Premium"], var.firewall_sku_tier)
    error_message = "The sku must be one of the following: Standard, Premium"
  }
}