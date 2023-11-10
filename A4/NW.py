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


def main_menu():
    menu = OptionsMenu()
    menu.display()


def more_options():
    submenu = MoreOptions()
    submenu.display()


def insert_cust() -> None:
    cursor.execute("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'northwind' AND TABLE_NAME = 'Customers';")
    result = cursor.fetchall()
    column_names = [row[0] for row in result]
    column_names = column_names[1:]
    print("To insert a customer into database, fill in the\n"
          "following fields (may be left blank).\n")

    values = []
    for column_name in column_names:
        value = input(f"Enter value for '{column_name}': ")
        if value == '':
            value = None
        values.append(value)

    columns = ", ".join(column_names)
    placeholder_values = ", ".join(["%s" for _ in column_names])
    sql = f"INSERT INTO Customers ({columns}) VALUES ({placeholder_values});"

    if input("Type (commit) to commit new customer addition\n").lower().startswith('commit'):
        try:
            cursor.execute(sql, values)
            cnx.commit()
            print("Customer added.")

        except mysql.connector.errors.Error as e:
            cnx.rollback()
            print(f"Error {e}.\nCustomer not added; rolling back transaction.")

    else:
        print("Customer addition canceled.")


def print_pending_orders():
    cursor.execute("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'northwind' AND TABLE_NAME = 'Orders';")
    result = cursor.fetchall()
    column_names = [row[0] for row in result]

    cursor.execute("SELECT * FROM orders WHERE ShippedDate IS NULL ORDER BY OrderDate ASC;")
    pending_orders = cursor.fetchall()

    print("╒══════════════╤══════════════════════╕")
    for order in pending_orders:
        order_details = [f"│ {col_name: <12} │ {str(value): <20} │" for col_name, value in zip(column_names, order)]
        print("\n".join(order_details),
              "\n╞══════════════╪══════════════════════╡")
    print(f"│ # pnd orders │ {len(pending_orders): <20} │\n"
          f"╘══════════════╧══════════════════════╛")

    main_menu()


def db_exit() -> None:
    print("Closing DB connection and exiting. Goodbye!")
    cursor.close()
    cnx.close()
    quit()


def db_message(msg_id: int) -> str:
    query = "SELECT Message FROM messages WHERE ID = '%s'"
    cursor.execute(query, (msg_id,))
    message = cursor.fetchone()
    return message[0]


class OptionsMenu:
    def __init__(self):
        self.title = "Menu"
        self.options = {
            1: ("add a customer", insert_cust),
            2: ("add an order", db_exit),
            3: ("remove an order", db_exit),
            4: ("ship an order", db_exit),
            5: ("print pending orders", print_pending_orders),
            6: ("more options", more_options),
            7: ("exit", db_exit)
        }

    def display(self):
        print(f"┌────────────────────────────────────────────────┐\n"
              f"│ {self.title: <47}│\n"
              f"├────────────────────────────────────────────────┤")
        for option_number in self.options:
            print(f'│ ({option_number}) {self.options[option_number][0]: <43}│')
        print(f"├────────────────────────────────────────────────┤\n"
              f"│ Enter a number below to make a selection       │\n"
              f"└────────────────────────────────────────────────┘")
        while True:
            try:
                selection = int(input("▷ "))
                self.options[selection][1]()
            except KeyError:
                print("Invalid selection")
            except ValueError:
                print("Invalid selection.")


class MoreOptions(OptionsMenu):
    def __init__(self):
        super().__init__()
        self.title = "More Options"
        self.options = {
            1: ("add things", db_exit),
            2: ("to this", db_exit),
            3: ("later", db_exit),
            4: ("previous menu", main_menu)
        }


main_menu()


cursor.close()
cnx.close()
