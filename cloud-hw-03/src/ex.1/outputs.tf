# Вывод публичного IP NLB
output "nlb_ip" {
  value = try(
    one(flatten([
      for listener in data.yandex_lb_network_load_balancer.nlb_data.listener :
      length(listener.external_address_spec) > 0 ? [one(listener.external_address_spec[*].address)] : [] ])),"No external IP assigned yet")

  depends_on = [ yandex_lb_network_load_balancer.nlb ]
}

# Вывод публичного IP ALB
output "alb_ip" {
  value = yandex_alb_load_balancer.alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
  depends_on = [ yandex_alb_load_balancer.alb ]
}
