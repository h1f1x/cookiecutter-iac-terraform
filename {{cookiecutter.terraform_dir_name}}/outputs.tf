output "ddb_table_name" {
  description = "Name of the dynamo db table"
  value = aws_dynamodb_table.example-dynamodb-table.name
}
