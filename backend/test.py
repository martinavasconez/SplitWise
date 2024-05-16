import json

def calculate_payments(input_json):
    # Calculate average total
    totals = [float(user["total"]) for user in input_json["totalPorUsuario"]]
    average_total = sum(totals) / len(totals)

    # Calculate debts
    debts = []
    for user in input_json["totalPorUsuario"]:
        id_usuario = user["id_usuario"]
        total = float(user["total"])
        deuda = round(total - average_total, 2)
        debts.append({
            "id_usuario": id_usuario,
            "deuda": deuda
        })

    # Separate into two lists: those who need to pay and those who need to be paid
    paying_users = [user for user in debts if user["deuda"] < 0]
    receiving_users = [user for user in debts if user["deuda"] > 0]

    # Initialize the result structure
    payments = {}

    # Use stacks to manage the debts
    while paying_users and receiving_users:
        payer = paying_users.pop(0)
        receiver = receiving_users.pop(0)

        pay_amount = min(-payer["deuda"], receiver["deuda"])

        if payer["id_usuario"] not in payments:
            payments[payer["id_usuario"]] = {}

        payments[payer["id_usuario"]][receiver["id_usuario"]] = f"{pay_amount:.2f}"

        payer["deuda"] += pay_amount
        receiver["deuda"] -= pay_amount

        if payer["deuda"] < 0:
            paying_users.insert(0, payer)
        if receiver["deuda"] > 0:
            receiving_users.insert(0, receiver)

    return payments

# Example input
input_json = {
  "totalPorUsuario": [
    {
      "id_usuario": 1,
      "total": "40.00"
    },
    {
      "id_usuario": 2,
      "total": "50.00"
    }
  ]
}

# Calculate payments
output_json = calculate_payments(input_json)

# Print the output in JSON format
print(json.dumps(output_json, indent=2))
