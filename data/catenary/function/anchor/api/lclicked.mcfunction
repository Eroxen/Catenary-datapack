execute on attacker run advancement grant @s only catenary:trigger/send_welcome_message

execute on passengers if entity @s[type=marker,tag=catenary.end_point] run function catenary:catenary/api/end_point_kill
function catenary:anchor/api/kill