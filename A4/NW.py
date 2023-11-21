# CS 4430 Assignment 4 by Christian Henning

import mysql.connector

# Establish a connection to the MySQL database.
# The connection attempts are retried up to 3 times if it fails initially.
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
        # Handle database connection errors
        failed_connection_attempts += 1
        print(e)
        if failed_connection_attempts < 3:
            print("reattempting connection...")
        elif input("unable to connect. retry? Y/N: ").lower().startswith('y'):
            failed_connection_attempts = 0
        else:
            quit("connection failed; exiting.")

    else:
        # Successful database connection
        print("Connected to MySQL server")
        cursor = cnx.cursor()
        break


def main_menu():
    """
    Display the main options menu to the user.
    This function creates an instance of the OptionsMenu class and displays it.
    """
    menu = OptionsMenu()
    menu.display()


def more_options():
    """
    Display a submenu with additional options to the user.
    This function creates an instance of the MoreOptions class and displays it.
    """
    submenu = MoreOptions()
    submenu.display()


def insert_cust() -> None:
    """
    Insert a new customer into the database.
    Prompts the user to fill in fields for the new customer.
    Fields may be left blank. Inserts the new customer into the database
    after user confirmation and displays the ID of the newly added customer.
    """
    column_names = get_col_names('Customers')
    column_names = column_names[1:]  # Exclude the ID column which is auto-incremented
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

    if input(db_message(14) + " Y/N: ").lower().startswith('y'):
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
    """
    Add a new order into the database.
    This function prompts the user to fill in fields for a new order.
    Fields related to foreign keys are validated against valid values from the referenced tables.
    The function commits the new order to the database after user confirmation.
    """
    column_names = get_col_names('Orders')
    column_names = column_names[1:]  # Exclude the ID column which is auto-incremented
    print("To add an order into the database, fill in\n"
          "the following fields (some may be left blank).\n")

    # Fetch foreign key constraints and their valid values for validation
    raw_constraints = get_fk_constraints('Orders')
    constraints = {}
    for row in raw_constraints:
        valid_inputs = get_valid_fk_value(row[1], row[2])
        constraints[row[0]] = valid_inputs

    # Collect user inputs, validating against FK constraints
    values = []
    for col in column_names:
        required = False
        if col in constraints:
            required = True

        value = input(f"Enter value for '{col}'{' (Required)' if required else ''}"
                      f"{'. Use YYYY/MM/DD HH:MM:SS format' if 'Date' in col else ''}: ")
        if value == '':
            value = None
        while required:
            if value not in constraints[col]:
                print("Invalid input; try again.\nValid inputs for are:", ", ".join(constraints[col]))
                value = input(f"Enter value for '{col}'{' (Required)' if required else ''}"
                              f"{'. Use YYYY/MM/DD HH:MM:SS format' if 'Date' in col else ''}: ")

            else:
                values.append(value)
                break

    # Construct and execute SQL query
    columns = ", ".join(column_names)
    placeholder_values = ", ".join(["%s" for _ in column_names])
    sql = f"INSERT INTO Orders ({columns}) VALUES ({placeholder_values});"

    if input(db_message(14) + " Y/N: ").lower().startswith('y'):
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


def cancel_order() -> None:
    """
    Cancel and delete an order from the database.
    This function deletes an order based on the provided order ID,
    including related entries in dependent tables such as order_details,
    invoices, and inventory_transactions.
    """
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
    sql2 = "DELETE orders FROM orders WHERE OrderID = %s;"
    print("Enter an ID to delete an order from the database.\n"
          "(or leave blank to abort)\n")

    order_id = input("Order ID to cancel: ")
    if order_id == '':
        print("No order selected; aborting")
        main_menu()

    print(db_message(49))
    if input(db_message(14) + " Y/N: ").lower().startswith('y'):
        try:
            id_to_delete = (order_id,)
            cursor.execute(sql1, id_to_delete)
            cursor.execute(sql2, id_to_delete)
            cnx.commit()
            print(db_message(102), "Order:", order_id)

        except mysql.connector.errors.Error:
            cnx.rollback()
            print(db_message(102))

        finally:
            main_menu()
    else:
        print("Order deletion canceled.")
        main_menu()


def ship_order() -> None:
    """
    Marks an order as shipped in the database.
    Updates the ShippedDate and StatusID for an order based on the provided order ID.
    """
    print("Enter the ID of the order to mark as shipped.\n"
          "(or leave blank to abort)\n")

    order_id = input("Order ID to ship: ")
    if order_id == '':
        print("No order selected; aborting")
        main_menu()
        return

    SHIPPED_STATUS_ID = 2

    sql = """
    UPDATE Orders 
    SET ShippedDate = CURRENT_DATE, StatusID = %s
    WHERE OrderID = %s;
    """

    print(f"About to mark order {order_id} as shipped.\n")
    if input("Proceed with shipping? Y/N: ").lower().startswith('y'):
        try:
            cursor.execute(sql, (SHIPPED_STATUS_ID, order_id))
            cnx.commit()
            print(f"Order {order_id} marked as shipped.")

        except mysql.connector.errors.Error as e:
            cnx.rollback()
            print(f"Error {e}.\nFailed to mark order as shipped; rolling back transaction.")

        finally:
            main_menu()
    else:
        print("Shipping operation canceled.")
        main_menu()


def print_pending_orders() -> None:
    """
    Prints a list of pending orders (orders not shipped yet) along with customer information.
    This function fetches and displays the order ID, order date, and customer details for all pending orders.
    It also offers the option to save this list to a file.
    """
    sql = """
    SELECT o.OrderID, o.OrderDate, c.Company, c.LastName, c.FirstName
    FROM orders o
    JOIN northwind.customers c
        ON c.ID = o.CustomerID
    WHERE ShippedDate IS NULL
    ORDER BY OrderDate;
    """
    cursor.execute(sql)
    pending_orders = cursor.fetchall()
    column_names = [i[0] for i in cursor.description]

    # Displaying the pending orders
    print("╒══════════════╤══════════════════════╕")
    for order in pending_orders:
        order_details = [f"│ {col_name: <12} │ {str(value): <20} │"
                         for col_name, value in zip(column_names, order)]
        print("\n".join(order_details),
              "\n╞══════════════╪══════════════════════╡")
    print(f"│ # pnd orders │ {len(pending_orders): <20} │\n"
          f"╘══════════════╧══════════════════════╛")

    # Option to save the data to a file
    save_file = input("Would you like to save the list to a file? Y/N: ").lower().startswith('y')
    if save_file:
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
    """
    Closes the database connection and exits the program.
    This function should be called to cleanly exit the application.
    """
    print("Closing database connection and exiting. Goodbye!")
    cursor.close()
    cnx.close()
    quit()


def db_message(msg_id: int) -> str:
    """
    Retrieves a specific message from the 'Message' table in the database.
    :param msg_id: The ID of the message to retrieve.
    :returns: The message text.
    """
    sql = "SELECT Message FROM messages WHERE ID = '%s'"
    cursor.execute(sql, (msg_id,))
    message = cursor.fetchone()
    return message[0] if message else "***Message not found***"


def get_col_names(table_name: str) -> list:
    """
    Retrieves the column names for a specified table.
    :param table_name: The name of the table to get column names from.
    :returns: A list of column names for the table.
    """
    sql = f"SELECT * FROM {table_name} LIMIT 0;"
    cursor.execute(sql)
    column_names = [i[0] for i in cursor.description]
    cursor.fetchall()   # clears cursor
    return column_names


def get_fk_constraints(table_name: str) -> list:
    """
    Retrieves foreign key constraints for a specified table.
    :param table_name: The name of the table to get foreign key constraints from.
    :returns: A list of tuples with column name, referenced table name, and referenced column name.
    """
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
    """
    Retrieves distinct values from a referenced table and column, useful for foreign key validation.
    :param ref_table: The name of the referenced table.
    :param ref_column: The name of the referenced column.
    :returns: A list of valid values for the foreign key.
    """
    cursor.execute(f"SELECT DISTINCT {ref_column} FROM {ref_table};")
    result = [str(row[0]) for row in cursor.fetchall()]
    return result


class OptionsMenu:
    """
    Class representing the main options menu.
    Each option in the menu is mapped to a corresponding function that implements the option's functionality.
    """

    def __init__(self):
        self.title = "Main Menu"
        self.options = {
            1: ("Add a customer", insert_cust),
            2: ("Add an order", add_order),
            3: ("Remove an order", cancel_order),
            4: ("Ship an order", ship_order),
            5: ("Print pending orders", print_pending_orders),
            6: ("More options", more_options),
            7: ("Exit", db_exit)
        }

    def display(self):
        """
        Displays the menu options and prompts the user to make a selection.
        The selected option's corresponding function is then executed.
        """
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
    """
    Class representing a submenu with additional options.
    Inherits from OptionsMenu and extends it with additional choices.
    """

    def __init__(self):
        super().__init__()
        self.title = "More Options"
        self.options = {
            1: ("add things", print),
            2: ("to this", print),
            3: ("later", print),
            4: ("previous menu", main_menu)
        }


if __name__ == "__main__":
    main_menu()
