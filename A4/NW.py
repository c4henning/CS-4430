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


def db_message(msg_id: int) -> str:
    query = "SELECT Message FROM messages WHERE ID = '%s'"
    cursor.execute(query, (msg_id,))
    message = cursor.fetchone()
    return message[0]


class RootMenu:
    def __init__(self):
        self.title = "Root Menu"
        self.options = {
            1: "add a customer",
            2: "add an order",
            3: "remove an order",
            4: "ship an order",
            5: "print pending orders",
            6: "more options",
            7: "exit"
        }

    def display(self):
        print(f"┌────────────────────────────────────────────────┐\n"
              f"│ {self.title: <47}│\n"
              f"├────────────────────────────────────────────────┤")
        for opt in self.options:
            print(f'│ {opt}. {self.options[opt]: <44}│')
        print(f"└────────────────────────────────────────────────┘")


class Opt1(RootMenu):
    def __init__(self):
        super().__init__()
        self.title = "add a customer"
        self.options = {
            1: "add a customer",
            2: "add an order",
            3: "remove an order",
            4: "ship an order",
            5: "print pending orders",
            6: "more options",
            7: "exit"
        }


menu = RootMenu()
menu.display()

submenu = Opt1()
submenu.display()

cursor.close()
cnx.close()









def insert_cust():
    cursor.execute("SELECT COLUMN_NAME"
                   "FROM INFORMATION_SCHEMA.COLUMNS"
                   "WHERE TABLE_NAME = 'Customers'")
    column_names = [row[0] for row in cursor.fetchall()]

    values = []
    for column_name in column_names:
        value = input(f"Enter value for '{column_name}': ")
        values.append(value)