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


def insert_cust():
    cursor.execute("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'northwind' AND TABLE_NAME = 'Customers'")
    column_names = [row[0] for row in cursor.fetchall()]
    print(column_names)
    column_names = column_names[1:]
    values = []
    for column_name in column_names:
        value = input(f"Enter value for '{column_name}': ")
        if value == '':
            value = None
        values.append(value)

    columns = ", ".join(column_names)
    prepared_values = ", ".join(["%s" for _ in column_names])
    sql = f"INSERT INTO Customers ({columns}) VALUES ({prepared_values})"

    cursor.execute(sql, values)


insert_cust()
cnx.rollback()


cursor.close()
cnx.close()
