# Northwind Database Management System

CS 4430 Assignment 4 by Christian Henning 

This project is a Python-based interface for managing the Northwind sample database. It provides a menu-driven user interface for performing various database operations, such as adding customers and orders, removing orders, and more.

## Features

- **Database Connection Handling**: Automated retry logic for establishing database connections.
- **Dynamic Schema Interaction**: Dynamically fetches column names and foreign key constraints for data validation.
- **CRUD Operations**: Supports Create, Read, Update, and Delete operations on various database tables.
- **Order Management**: Includes functionalities to add, remove, and ship orders.
- **Customer Management**: Allows adding new customers to the database.
- **Data Validation**: Enforces foreign key constraints and data type checks based on the database schema.
- **Error Handling**: Robust error handling with transaction rollbacks in case of failures.
- **Interactive Menus**: User-friendly text-based menus for navigating through different functionalities.

## Getting Started

### Prerequisites

- Python 3.x
- MySQL server (local or remote)
- `mysql-connector-python` package

### Installation

1. Ensure Python 3.x is installed on your system.
2. Install `mysql-connector-python` using pip:
   ```bash
   pip install mysql-connector-python
    ```
   
### Setting up the Database
1. Set up the Northwind sample database in your MySQL server.
2. Update the database connection details (host, user, password, database name) in the script to match your MySQL server configuration.
   - The connection details to be updated are found on lines 12 - 15 of `NW.py`
   - The default prepopulated values are `host="localhost",
            user="root",
            password="",
            database="northwind"`

### Running the Application
Execute the script from your terminal or command prompt:
```bash
python NW.py
```

## Usage

After running the script, you will be presented with a main menu of operations. Navigate through the menu by entering the number corresponding to the desired operation. Follow the on-screen prompts to perform database operations.

## Source Code

The [source code](https://github.com/c4henning/CS-4430/blob/main/A4/NW.py) for this project along with development history can be found on my GitHub!