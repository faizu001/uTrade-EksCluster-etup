# # Create VPC peering connection from my-vpc to node-vpc
# resource "aws_vpc_peering_connection" "my-vpc-to-node-vpc" {
#   peer_vpc_id    = aws_vpc.node-vpc.id
#   vpc_id         = aws_vpc.my-vpc.id
#   auto_accept    = true  # This auto-accepts the peering request
# }

# # Accept VPC peering connection from node-vpc to my-vpc
# resource "aws_vpc_peering_connection_accepter" "node-vpc-to-my-vpc" {
#   provider             = aws  # Specify the AWS provider here
#   vpc_peering_connection_id = aws_vpc_peering_connection.my-vpc-to-node-vpc.id
# }
