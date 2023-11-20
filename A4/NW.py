# 1. add a customer -- DONE --
# 2. add an order -- DONE --
# 3. remove an order -- DONE --
# 4. ship an order
# 5. print pending orders (not shipped yet) with customer information
# 6. more options -- DONE --
# 7. exit -- DONE --

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
    column_names = get_col_names('Customers')
    column_names = column_names[1:]
    print("To insert a customer into the database, fill in\n"
          "the following fields (may be left blank).\n")

    values = []
    for col in column_names:
        value = input(f"Enter value for '{col}': ")
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
            cursor.execute("SELECT LAST_INSERT_ID();")
            last_id = cursor.fetchone()[0]
            print(f"Customer added with ID: {last_id}")

        except mysql.connector.errors.Error as e:
            cnx.rollback()
            print(f"Error {e}.\nCustomer not added; rolling back transaction.")

        finally:
            main_menu()

    else:
        print("Customer addition canceled.")
        main_menu()


def add_order() -> None:
    column_names = get_col_names('Orders')
    column_names = column_names[1:]
    print("To add an order into the database, fill in\n"
          "the following fields (some may be left blank).\n")

    raw_constraints = get_fk_constraints('orders')
    constraints = {}
    for row in raw_constraints:
        valid_inputs = get_valid_fk_value(row[1], row[2])
        constraints[row[0]] = valid_inputs

    values = []
    for col in column_names:
        required = False
        if col in constraints:
            required = True

        value = input(f"Enter value for '{col}'{' (Required)' if required else ''}: ")
        if value == '':
            value = None
        while required:
            if value not in constraints[col]:
                print("Invalid input; try again.\nValid inputs for are:", ", ".join(constraints[col]))
                value = input(f"Enter value for '{col}'{' (Required)' if required else ''}: ")

            else:
                values.append(value)
                break

        else:
            values.append(value)

    columns = ", ".join(column_names)
    placeholder_values = ", ".join(["%s" for _ in column_names])
    sql = f"INSERT INTO Orders ({columns}) VALUES ({placeholder_values});"

    if input("Type (commit) to commit new order addition\n").lower().startswith('commit'):
        try:
            cursor.execute(sql, values)
            cnx.commit()
            cursor.execute("SELECT LAST_INSERT_ID();")
            last_id = cursor.fetchone()[0]
            print(f"Order added with ID: {last_id}")

        except mysql.connector.errors.Error as e:
            cnx.rollback()
            print(f"Error {e}.\nOrder not added; rolling back transaction.")

        finally:
            main_menu()

    else:
        print("Order addition canceled.")
        main_menu()


def delete_order() -> None:
    # dependant tables to be deleted
    sql1 = """
    DELETE od, i, it 
    FROM orders o 
    LEFT JOIN order_details od 
        ON o.OrderID = od.OrderID 
    LEFT JOIN invoices i 
        ON o.OrderID = i.OrderID 
    LEFT JOIN inventory_transactions it 
        ON o.OrderID = it.CustomerOrderID 
    WHERE o.OrderID = %s;
    """
    # order to be deleted once fk constraints resolved
    sql2 = "DELETE orders FROM orders WHERE OrderID = %s;"
    print("Enter an ID to delete an order from the database.\n"
          "(or leave blank to abort)\n")

    order_id = input("ID to delete: ")
    if order_id == '':
        print("No order selected; aborting")
        main_menu()

    elif input("Type (commit) to commit order deletion\n").lower().startswith('commit'):
        id_to_delete = (order_id,)
        try:
            cursor.execute(sql1, id_to_delete)
            cursor.execute(sql2, id_to_delete)
            cnx.commit()
            print(f"Order {order_id} deleted.")

        except mysql.connector.errors.Error as e:
            cnx.rollback()
            print(f"Error {e}.\nOrder not deleted; rolling back transaction.")

        except Exception as e:
            print(e)

        finally:
            main_menu()
    else:
        print("Order deletion canceled.")
        main_menu()


def ship_order() -> None:

    main_menu()


def print_pending_orders() -> None:
    column_names = get_col_names('Orders')
    cursor.execute("SELECT * FROM orders WHERE ShippedDate IS NULL ORDER BY OrderDate ASC;")
    pending_orders = cursor.fetchall()

    print("╒══════════════╤══════════════════════╕")
    for order in pending_orders:
        order_details = [f"│ {col_name: <12} │ {str(value): <20} │"
                         for col_name, value in zip(column_names, order)]
        print("\n".join(order_details),
              "\n╞══════════════╪══════════════════════╡")
    print(f"│ # pnd orders │ {len(pending_orders): <20} │\n"
          f"╘══════════════╧══════════════════════╛")

    if True:
        file_name = "pending_orders.txt"
        with open(file_name, "w", encoding="utf-16") as output:
            output.write("╒══════════════╤══════════════════════╕\n")
            for order in pending_orders:
                order_details = [f"│ {col_name: <12} │ {str(value): <20} │"
                                 for col_name, value in zip(column_names, order)]
                output.write("\n".join(order_details))
                output.write("\n╞══════════════╪══════════════════════╡\n")
            output.write(f"│ # pnd orders │ {len(pending_orders): <20} │\n")
            output.write("╘══════════════╧══════════════════════╛\n")

        print("Pending orders file generated with filename:", file_name)

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


def get_col_names(table_name: str) -> list:
    cust_col_query = f"""
    SELECT 
        COLUMN_NAME 
    FROM 
        INFORMATION_SCHEMA.COLUMNS 
    WHERE 
        TABLE_SCHEMA = 'northwind' 
        AND TABLE_NAME = '{table_name}';
    """
    cursor.execute(cust_col_query)
    result = cursor.fetchall()
    return [row[0] for row in result]


def get_fk_constraints(table_name: str) -> list:
    fk_query = """
    SELECT 
        COLUMN_NAME, 
        REFERENCED_TABLE_NAME, 
        REFERENCED_COLUMN_NAME 
    FROM 
        INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
    WHERE 
        TABLE_SCHEMA = 'northwind' 
        AND TABLE_NAME = %s 
        AND REFERENCED_TABLE_NAME IS NOT NULL;
    """

    cursor.execute(fk_query, (table_name,))
    return cursor.fetchall()


def get_valid_fk_value(ref_table: str, ref_column: str) -> list:
    cursor.execute(f"SELECT DISTINCT {ref_column} FROM {ref_table};")
    result = [str(row[0]) for row in cursor.fetchall()]
    return result


class OptionsMenu:
    def __init__(self):
        self.title = "Menu"
        self.options = {
            1: ("add a customer", insert_cust),
            2: ("add an order", add_order),
            3: ("remove an order", delete_order),
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


print("DEBUG:\nthere was an error. we shouldn't be here.")
cursor.close()
cnx.close()
