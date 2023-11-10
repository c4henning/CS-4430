import mysql.connector

cnx = None
failed_connection_attempts = 0
while True:
    try:
        cnx = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="northwind"
        )

    except mysql.connector.errors.DatabaseError as e:
        failed_connection_attempts += 1
        print(e)
        if failed_connection_attempts < 3:
            print("reattempting connection...")
        elif input("unable to connect. retry? y/n: ").lower().startswith('y'):
            failed_connection_attempts = 0
        else:
            quit("connection failed; exiting.")

    else:
        print("connected to MySQL server")
        cursor = cnx.cursor()
        break
# CODE BELOW #############################################################


def print_pending_orders():
    cursor.execute("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'northwind' AND TABLE_NAME = 'Orders';")
    result = cursor.fetchall()
    column_names = [row[0] for row in result]
    cursor.execute("SELECT * FROM orders WHERE ShippedDate IS NULL ORDER BY OrderDate ASC;")
    pending_orders = cursor.fetchall()
    for order in pending_orders:
        order_details = [f"{col_name: <12}| {value}" for col_name, value in zip(column_names, order)]
        print("\n".join(order_details), "\n---------------------------------")


print_pending_orders()


# CODE ABOVE #############################################################
cnx.rollback()
cursor.close()
cnx.close()
